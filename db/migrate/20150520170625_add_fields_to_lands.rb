class AddFieldsToLands < ActiveRecord::Migration
  def change
    add_column :lands, :bedrooms, :integer
    add_column :lands, :bathrooms, :decimal
    add_column :lands, :sqft, :integer
    add_column :lands, :cats, :string
    add_column :lands, :dogs, :string
    add_column :lands, :w_d_in_units, :string
    add_column :lands, :street_parking, :string
  end
end
