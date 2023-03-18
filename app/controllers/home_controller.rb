class HomeController < ApplicationController
    before_action :authenticate_user!
    include HTTParty

    def index
        @products = fecth_products.sort_by  { |product| product['price'] }.reverse
        @products = @products.sort_by  { |product| product['title'].downcase } if params[:sort] == 'name'
        if params[:name_filter].present?
          @products = @products.select { |product| product['title'].downcase.include?(params[:name_filter]) } 
        end
        if params[:price_min].present? && params[:price_max].present?
          @products = @products.select { |product| (params[:price_min].to_f..params[:price_max].to_f).include?(product['price'].to_f) } 
        end
        if params[:clear_filters].present?
          redirect_to root_path
        end
    end

    private

    def fecth_products
        response_fake = HTTParty.get('https://fakestoreapi.com/products')
        fake_store_body = JSON.parse(response_fake.body)
        response_dummy = HTTParty.get('https://dummyjson.com/products')
        dummy_store_body = JSON.parse(response_dummy.body)['products']
        fake_store_body + dummy_store_body
    end
end
