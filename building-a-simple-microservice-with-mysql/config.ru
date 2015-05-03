require 'grape'
require 'grape-swagger'
require 'grape-entity'
require 'rack/cors'
require 'dotenv'
Dotenv.load

require_relative 'app/models/products'
require_relative 'app/models/product'
require_relative 'app/representers/entities'
require_relative 'app/api/products_api'
require_relative 'app/api/diagnostic_api'

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [ :get, :post, :put, :delete, :options ]
  end
end

class API < Grape::API
  format :json
  default_format :json

  mount ProductsApi
  mount DiagnosticApi
  add_swagger_documentation api_version: 'v1', hide_documentation_path: true,
                            produces:[],
                            hide_format: true, format: 'json',
                            models: [Entities::Product, Entities::Products]
end

# project_root = File.expand_path('../../', File.dirname(__FILE__))
# Dotenv.load(project_root + '/.env')

use Rack::Static, urls: ['/public']
run API.new
