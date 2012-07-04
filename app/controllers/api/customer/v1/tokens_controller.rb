class Api::Customer::V1::TokensController  < Api::Customer::V1::BaseController
  skip_before_filter :authenticate_customer!

  def create
    if params[:email].nil? || params[:domain_name].nil? || params[:secret_key].nil?
      render status: 400, json: { code: 1, message: "The request must contain an email, domain name and secret key." }
      return
    end

    @customer = Customer.where(email: params[:email].downcase).first

    if @customer.nil?
      render status: 400, json: { code: 10, message: "The email is not in our database." }
      return
    end

    @site = @customer.sites.where(domain_name: params[:domain_name].downcase).first

    if @site.nil? || ! @site.confirmed?
      render status: 400, json: { code: 20, message: "The domain name has not been confirmed." }
      return
    end

    if @site.secret_key == params[:secret_key]
      @customer.ensure_authentication_token!
      render status: 200, json: { token: @customer.authentication_token }
    else
      render status: 400, json: { code: 21, message: "The secret key is not valid." }
    end
  end

  def destroy
    @customer = Customer.where(authentication_token: params[:id]).first
    if @customer.nil?
      render status: 404, json: { code: 11, message: "Invalid token." }
    else
      @customer.reset_authentication_token!
      render status: 200, json: { token: params[:id] }
    end
  end

end
