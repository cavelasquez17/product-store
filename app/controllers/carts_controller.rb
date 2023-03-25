class CartsController < ApplicationController
    before_action :authenticate_user!

    def index
        @cart = current_user.cart
        @total_price = @cart&.product_items&.sum(&:price)
    end

    def add_product
        validate_quantity
        @product_item = product_item
        @cart = current_user.cart || current_user.create_cart
        @cart.product_items << @product_item
        
        flash[:success] = "Añadido al carrito con éxito"
        redirect_to show_product_path(product: @product)  
    end

    def delete_product
        @cart = current_user.cart
        @product_item = @cart.product_items.find(params[:id])
        @product_item.destroy
        redirect_to @cart, notice: "Producto eliminado de mi carrito de compras"
    end

    private

    def product_item
        ProductItem.create(name: @product[:title], quantity: @quantity,
        price: @total_price , image: @product[:images].last)
    end

    def validate_quantity
        @product = product_params
        @quantity = params[:quantity].to_i
        @total_price = @product[:price].to_i * @quantity
        return unless @quantity > @product[:stock].to_i
        
        flash[:error] = "Lo sentimos, no hay suficiente stock disponible"
        redirect_to show_product_path(product: @product) and return
    end

    def product_params
        params.require(:product).permit(:category, :rating, :stock, :description, :price, :image, :title, :id, rating: [:count, :rate], images: [], product: [])
    end
end
