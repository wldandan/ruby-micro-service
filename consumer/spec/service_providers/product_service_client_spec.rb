require_relative './pact_helper'
require_relative '../../app/service/product_service_client'

describe ProductServiceClient, pact: true do

  before do
    ProductServiceClient.base_uri 'localhost:1234'
  end

  subject { ProductServiceClient.new }

  describe 'get_products' do
    before do
      product_service.given('products exist').
          upon_receiving('a request for all products').
          with(method: :get, path: '/products').
          will_respond_with(
              status: 200,
              headers: {'Content-Type' => 'application/json'},
              body: [{name: 'Docker In Action', price: 56.0},
                     {name: 'Agile Method', price: 46}])
    end

    it "returns products" do
      expect(subject.get_products).to match_array([{'name' => 'Docker In Action', 'price' => 56.0},
                                          {'name' => 'Agile Method', 'price' => 46}])
    end
  end

  describe 'get_product' do
    before do
      product_service.given('product with id 1 exist').
          upon_receiving('a request for a product').
          with(method: :get, path: '/products/1').
          will_respond_with(
              status: 200,
              headers: {'Content-Type' => 'application/json'},
              body: {name: 'Docker In Action', price: 56.0})
    end

    it "returns products" do
      expect(subject.get_product(1)).to eq({'name' => 'Docker In Action', 'price' => 56.0})
    end
  end

end