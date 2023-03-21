class CreateCartsProductItems < ActiveRecord::Migration[7.0]
  def change
    create_table :carts_product_items do |t|
      t.belongs_to :cart
      t.belongs_to :product_item
    end
  end
end
