#!/bin/bash
set -e

# Declare build-deps
rpm -q chruby

# Allow deploy/ci.sh to set the path to the project root dir so we can reuse ci.sh.
# Not very elegant - if someone can think of a better way to do this, please improve it!
if [ -z "$PROJECT_ROOT_DIR" ]; then
  PROJECT_ROOT_DIR="."
fi

RUBY_VERSION=$(grep -o "[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}" ${PROJECT_ROOT_DIR}/.ruby-version)

# Check if this ruby version is available in repo
# if not, use a main version instead
yum search chruby-ruby-${RUBY_VERSION}

if [ "${?}" -eq 0 ]; then
  MAIN_RUBY_VERSION=${RUBY_VERSION%.*}
  echo "chruby-ruby-${RUBY_VERSION} not found on the repo, using ${MAIN_RUBY_VERSION} instead."
  RUBY_VERSION=${MAIN_RUBY_VERSION}
fi

echo "Using ruby version ${RUBY_VERSION}"

# Install ruby if not installed
if ! rpm -qa | grep -qw chruby-ruby-${RUBY_VERSION}; then
  sudo yum install -y chruby-ruby-${RUBY_VERSION}
fi

# Use ruby specified in .ruby-version file
source /usr/share/chruby/chruby.sh
chruby ruby-${RUBY_VERSION}
type ruby
ruby -v

# Bootstrap bundler
BUNDLER_VERSION=$(cat ${PROJECT_ROOT_DIR}/.bundler-version)
gem specification bundler -v "$BUNDLER_VERSION" >/dev/null 2>&1 || gem install --no-rdoc --no-ri bundler -v "$BUNDLER_VERSION"

bundle -v

bundle install

# Delegate to rake
bundle exec rake "$@"
