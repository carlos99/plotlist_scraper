class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.text :url
      t.references :land, index: true

      t.timestamps null: false
    end
    add_foreign_key :images, :lands
  end
end
