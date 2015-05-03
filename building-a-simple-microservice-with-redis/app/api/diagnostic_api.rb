require 'json'

class DiagnosticApi < Grape::API
  version 'v1', using: :path
  format :json
  default_format :json

  namespace :diagnostic do

    get '/', http_codes: [[200, 'Ok']] do
      {data: "pong"}
    end

    get '/version', http_codes: [[200, 'Ok']] do
      { version: '1.2.6' }
    end

    get '/build-time', http_codes: [[200, 'Ok']] do
      { build_time: '2015-05-01 11:39:00' }
    end

    get '/hostname', http_codes: [[200, 'Ok']] do
      { hostname: '10.2.1.10' }
    end

  end
end
