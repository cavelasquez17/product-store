class ApplicationController < ActionController::Base
    URL_FAKE_STORE = Rails.application.credentials.dig(:products_url, :fake_store).to_s.freeze
    URL_DUMMY_STORE = Rails.application.credentials.dig(:products_url, :dummy_store).to_s.freeze
end
