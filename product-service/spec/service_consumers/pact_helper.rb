require 'pact/provider/rspec'
require_relative 'products_provider_spec.rb'

Pact.service_provider "Product Service" do

  honours_pact_with 'Consumer' do

    # This example points to a local file, however, on a real project with a continuous
    # integration box, you would use a [Pact Broker](https://github.com/bethesque/pact_broker) or publish your pacts as artifacts,
    # and point the pact_uri to the pact published by the last successful build.

    pact_uri '../consumer/specs/pacts/product_consumer-product_service.json'
  end
end