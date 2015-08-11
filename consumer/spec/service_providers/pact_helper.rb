require 'pact/consumer/rspec'
# or require 'pact/consumer/minitest' if you are using Minitest

Pact.service_consumer "Product Consumer" do
  has_pact_with "Product Service" do
    mock_service :product_service do
      port 1234
    end
  end
end