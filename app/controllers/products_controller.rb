class ProductsController < ApplicationController
    def show_product
        @product = OpenStruct.new(product_details)
    end

    def purchase_product
        @product = product_params 
        @quantity = params[:quantity].to_i
        @total_cost = @product[:price].to_i * @quantity
        if @quantity > @product[:stock].to_i
          flash[:error] = "Lo sentimos, no hay suficiente stock disponible"
          redirect_to @product and return
        end
        
        flash[:success] = "Compra realizada con éxito"
        redirect_to @product
    end

    private

    def product_details
        { category: product_params['category'], description: product_params['description'], 
         title: product_params['title'], rating: validate_rating,
         images: product_params['images'] || product_params['image'], price: product_params['price'],
         stock: validate_stock }
    end

    def validate_stock
        return product_params['stock'] if product_params['stock'].present?
            
        product_params['rating']['count']
    end

    def validate_rating
        return product_params['rating'] unless product_params['rating']['rate'].present?
    
        product_params['rating']['rate']
    end

    def product_params
        params.require(:product).permit(:category, :rating, :stock, :description, :price, :image, :title, :id, rating: [:count, :rate], images: [], product: [])
    end
end
