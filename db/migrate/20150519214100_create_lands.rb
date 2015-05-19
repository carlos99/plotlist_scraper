class CreateLands < ActiveRecord::Migration
  def change
    create_table :lands do |t|
      t.string :heading
      t.text :body
      t.decimal :price
      t.string :neigborhood
      t.string :external_url
      t.string :timestamp

      t.timestamps null: false
    end
  end
end
