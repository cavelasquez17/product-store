class CreateProductItems < ActiveRecord::Migration[7.0]
  def change
    create_table :product_items do |t|
      t.string :name
      t.integer :quantity
      t.decimal :price
      t.string :image
      t.timestamps
    end
  end
end
