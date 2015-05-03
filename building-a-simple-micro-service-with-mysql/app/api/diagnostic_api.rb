require 'json'

class DiagnosticApi < Grape::API
  format :json
  default_format :json

  namespace :diagnostic, desc: 'Diagnostic operations(Application Supported Monitoring)' do

    get '/', http_codes: [[200, 'Ok']] do
      [
          {
              rel: "version",
              path: "/diagnostic/version"
          },
          {
              rel: "host",
              path: "/dianostic/host"
          },
          {
              rel: "config",
              path: "/diagnostic/config"
          },
          {
              rel: "status",
              path: "/dianostic/status"
          },
          {
              rel: "heartbeat",
              path: "/dianostic/status/heartbeat"
          },
          {
              rel: "nagios",
              path: "/dianostic/status/nagios"
          },
          {
              rel: "diagnosis",
              path: "/dianostic/status/diagnosis"
          }
      ]
    end

    get '/version', http_codes: [[200, 'Ok']] do
      { version: '1.2.6', env: 'production'}
    end

    get '/host', http_codes: [[200, 'Ok']] do
      { hostname: 'node-1.vpc-1.abc.com' }
    end

    get '/config',  http_codes: [[200, 'Ok']] do
      { 'redis.host' => 'redis-node.vpc-1.abc.com',
        'db.host'    => 'mysql-node-1.vpc-1.abc.com' }
    end

    namespace :status do

      get '/', http_codes: [[200, 'Ok']] do
        [
            {
                rel: "heartbeat",
                path: "/status/heartbeat"
            },
            {
                rel: "nagios",
                path: "/status/nagios"
            },
            {
                rel: "diagnosis",
                path: "/status/diagnosis"
            }
        ]
      end

      get '/heartbeat', http_codes: [[200, 'Ok']] do
      end

      get '/nagios',  http_codes: [[200, 'Ok']] do
        'OK - the application is functioning correctly (on node-1.vpc-1.abc.com)'
      end

      get '/diagnosis',  http_codes: [[200, 'Ok']] do
        {
            hostname: 'node-1.vpc-1.abc.com',
            summary: 'All Good!',
            checks: [
                {
                    name: 'Database server check',
                    host: 'mysql-node-1.vpc-1.abc.com',
                    success: true,
                    duration: 0.004593516
                },
                {
                    name: 'Cache server check',
                    host: 'redis-node.vpc-1.abc.com',
                    success: true,
                    duration: 0.005332276
                },
                {
                    name: 'Config service check',
                    host: 'config-service-node-1.vpc-1.abc.com',
                    success: true,
                    duration: 0.004212312
                }
            ]
        }
      end
    end
  end
end
