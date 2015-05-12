Sequel.migration do
  change do
    create_table :products do
      primary_key :id
      String      :name
      String      :category
      BigDecimal  :price, size: [12, 4]
      DateTime    :created_at
      DateTime    :updated_at
    end
  end
end
