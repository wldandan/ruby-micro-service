Sequel.migration do
  change do
    create_table :records do
      primary_key :id
      String      :name
      BigDecimal  :price, size: [12, 4]
      DateTime    :expired_at
      DateTime    :created_at
      DateTime    :updated_at
    end
  end
end
