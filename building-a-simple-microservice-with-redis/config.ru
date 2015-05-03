require 'grape'
require 'grape-swagger'
require 'grape-entity'
require 'rack/cors'
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
  mount ProductsApi
  mount DiagnosticApi
  add_swagger_documentation api_version: 'v1', models: [Entities::Product, Entities::Products]
end

use Rack::Static, urls: ['/public']

run API.new
