class Cart < ApplicationRecord
    belongs_to :user
    has_and_belongs_to_many :product_items, join_table: :carts_product_items
end
