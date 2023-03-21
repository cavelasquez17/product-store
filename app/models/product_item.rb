class ProductItem < ApplicationRecord
    has_and_belongs_to_many :cart, join_table: :carts_product_items
end
