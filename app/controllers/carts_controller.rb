class CartsController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate, except: [:create]

  def show
    cart = Cart.find(params.fetch(:id))
    render json: cart.to_json
  rescue ActiveRecord::RecordNotFound => error
    logger = LogStashLogger.new(
      type: :tcp,
      host: 'localhost',
      port: 5000
    )

    logger.error LogStash::Event.new(
      code: 500,
      type: :request,
      url: request.url,
      method: request.request_method,
      token: @access_token
    )
    throw StandardError.new
  end

  def checkout
    cart = Cart.find_by(access_token: @access_token)
    cart.update(state: { checkout: true })
    render json: { message: 'Successful cart checkout' }
  end

  def create
    access_token = SecureRandom.uuid
    Cart.create!(store: Store.first, access_token: access_token)
    render json: { access_token: access_token }
  end

  private

  def authenticate
    authenticate_or_request_with_http_token do |token, _options|
      @access_token = token
      true
    end
  end

  def cart_params
    params.permit!
  end
end
