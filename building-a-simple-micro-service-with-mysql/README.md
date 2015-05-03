Service/App Name
================

Add a detailed description of the new service including:

* what it does
    Update location information of price in PSeeker.

* who uses it
    Pricing team.


## Component Custodian(s)

Pricing Squad [pp_pricing@rea-group.com](mailto:pp_pricing@rea-group.com) in Money tribe, Group Platform

| Name           | Email                          |
| :------------- |:-------------------------------|
| Adam Tohovitis | <adam.tohovitis@rea-group.com> |
| Wang Lei       | <wang.lei@rea-group.com>       |

## SOX requirements

Specify whether this repo has financial implications and is part of SOX requirements, or not.

## Change release process

Steps for change release, eg:

* Create code on feature branch or forked repository.
* Provide a Pull Request for merging into master and get a :thumbsup: from one of the custodians external to the work you have completed.
* Create a Change Request in Community, and have it approved by two DL's and/or Tech leads
* Deploy in accordance with deployment steps below.

## Service Level Agreements (SLA)

* Availability Window
  - ie is it 24 hours/7 days, 7am-7pm/7days, 9am-5pm/weekdays, etc (and if not 24/7 what happens Public Holidays?)
* Performance/response time during Availability Window
  - Last Byte Delivery 100% under 10 seconds during 7am to 7pm 99% of the time
* Availability - 99% uptime

## Usage

### Prod

* http://example.realestate.com.au
* Access restrictions
  * requires prod VPN
  * membership of AcmeWidgets LDAP group

### Test

* No test currently

## Troubleshooting

### Logs

## Deployment

## Development

### Testing

    $ bundle exec rake

### Running

    $ bundle exec rake

### Debugging

Any specific debugging tools built into the service

### Build

[Standalone (Bamboo)](http://master.ci.utah.corp.realestate.com.au:8085/browse/PRIC-PPU)

## Running with Docker

### Prerequisites
- [Virtualbox](https://www.virtualbox.org/)
- [Boot2Docker](https://docs.docker.com/installation/mac/)
- [Docker](https://docs.docker.com/installation/mac/)
- [Docker-compose](https://docs.docker.com/compose/install/) "the new fig"

### Up and Running

1. Set `DOCKER=true` in `.env.development`.
2. Build the docker image `docker-compose build`
3. To initialize the database `docker-compose bundle install`
4. To run the default rake build `docker-compose rake location:update [copy_from, current_location, new_location]`

Simples :-)


## Running Natively

### Prerequisites
- bundler

### Up and Running

1. Install specified ruby version (in `.ruby-version`).
2. `bundle install`
3. Manually check the `new location` data in PSeeker.
4. Confirm the `copy_from`.
5. `rake location:update[copy_from,historical_state,historical_suburb,historical_postcode,new_state,new_suburb,new_postcode]`

## Code Quality (Static Analysis)

Code complexity metrics provided by [Cane](https://github.com/square/cane):

    rake quality

Code format and convention check provided by [Rubocop](https://github.com/bbatsov/rubocop):

    rake rubocop

## Test Suite

To run the entire test suite (including functional tests):

    rake

### Test Coverage

If you would like a report of the test coverage, open "coverage/index.html" after running following task:

    rake spec
