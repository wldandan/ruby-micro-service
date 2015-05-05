require 'json'
require_relative '../../app/boot'

class ProductsApi < Grape::API
  format :json
  default_format :json

  rescue_from ServiceException do |error|
    logger.error error.message
    Rack::Response.new({ errors: error.message }.to_json, 404).finish
  end

  before do
    logger.info "#{env['REMOTE_ADDR']} #{env['HTTP_USER_AGENT']} #{env['REQUEST_METHOD']} #{env['REQUEST_PATH']}"
  end

  namespace :products, desc: 'Product operations' do
    desc 'List of products', entity: Entities::Products
    get '/', http_codes: [[200, 'Ok', Entities::Products, is_array: true]] do
      present ProductRepository.all, is_array: false, with: Entities::Products, type: :full
    end

    desc 'Adds a new products record.', entity: Entities::Product, params: Entities::Product.documentation.except(:id)
    post '/', http_codes: [ [ 201, 'Created', Entities::Product ] ] do
      present ProductRepository.create(params[:name], params[:price])
    end

    desc 'Returns a products record for the specified id', entity: Entities::Product
    params do
      requires :id, type: String, desc: 'Products record id'
    end
    get '/:id', http_codes: [[200, 'Ok', Entities::Product]] do
      present ProductRepository.find(params[:id]), with: Entities::Product, type: :full
    end

    desc 'Updates a products record for the specified id.',
        entity: Entities::Product, params: Entities::Product.documentation.except(:id)
    params do
      requires :id, type: String, desc: 'Products record id'
    end
    put '/:id', http_codes: [[ 200, 'Ok', Entities::Product]] do
      present ProductRepository.update(params[:id], params[:name], params[:price])
    end

    desc 'Deleted a products record for the specified id.'
    params do
      requires :id, type: String, desc: 'Products record id'
    end
    delete '/:id', http_codes: [ [ 200,  'Ok' ], [ 404,  'Not Found' ] ] do
      ProductRepository.delete(params[:id])
    end
  end
end
