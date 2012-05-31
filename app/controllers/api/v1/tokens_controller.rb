class Api::V1::TokensController  < Api::V1::BaseController
  skip_before_filter :authenticate_customer!

  def create
    if params[:email].nil?
      render status: 400, json: { message: "The request must contain the user email." }
    else
      @customer = Customer.find_or_create_by(email: params[:email].downcase)
      # TODO Verify if domain name is whitelisted
      @customer.ensure_authentication_token!
      render status: 200, json: { token: @customer.authentication_token }
    end
  end

  def destroy
    @customer = Customer.where(authentication_token: params[:id]).first
    if @customer.nil?
      render status: 404, json: { message: "Invalid token." }
    else
      @customer.reset_authentication_token!
      render status: 200, json: { token: params[:id] }
    end
  end

end
