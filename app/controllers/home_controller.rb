class HomeController < ApplicationController
    before_action :authenticate_user!
    include HTTParty

    def index
      @products = fecth_products.sort_by { |product| product['price'] }.reverse
      @products = @products.sort_by { |product| product['title'].downcase } if params[:sort] == 'name'
      # Obtener categorías únicas
      categories = @products.map { |p| p['category'] }.uniq
      # Tomar 5 categorías aleatorias
      @random_categories = categories.sample(5)
  
      if params[:category].present?
        @products = @products.select { |product| product['category'] == params[:category] }
      end
  
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
      request_apis(URL_FAKE_STORE) + request_apis(URL_DUMMY_STORE)
    end

    def request_apis(url)
      response = HTTParty.get(url)
      return JSON.parse(response.body)['products'] if url == URL_DUMMY_STORE

      JSON.parse(response.body)
    end
end
