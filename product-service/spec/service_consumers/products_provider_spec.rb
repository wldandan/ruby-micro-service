Pact.provider_states_for "Product Consumer" do

  provider_state "products exist" do
    set_up do
      product1 = Product.new({id: 1,
                              name: 'Docker In Action',
                              price: 56.0,
                              category: 'cloud',
                              created_at: '2015-08-11',
                              updated_at: '2015-08-11'})
      product2 = Product.new({id: 1,
                              name: 'Agile Method',
                              price: 46,
                              category: 'Agile',
                              created_at: '2015-08-11',
                              updated_at: '2015-08-11'})

      allow(ProductRepository).to receive(:all) { [product1, product2] }
    end
  end

  provider_state "product with id 1 exist" do
    set_up do
      product = Product.new({id: 1,
                              name: 'Docker In Action',
                              price: 56.0,
                              category: 'cloud',
                              created_at: '2015-08-11',
                              updated_at: '2015-08-11'})

      allow(ProductRepository).to receive(:find) { product }
    end
  end

end