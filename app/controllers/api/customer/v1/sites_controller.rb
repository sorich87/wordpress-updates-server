class Api::Customer::V1::SitesController < Api::Customer::V1::BaseController
  skip_before_filter :authenticate_customer!

  def create
    if params[:email].nil? || params[:domain_name].nil? || params[:secret_key].nil?
      render status: 400, json: { code: 1, message: "The request must contain an email, domain name and secret key." }
      return
    end

    @customer = Customer.find_or_create_by(email: params[:email].downcase)

    unless @customer.valid?
      render status: 400, json: { code: 2, message: "An error occured.", errors: @customer.errors.full_messages }
      return
    end

    @site = @customer.sites.where(domain_name: params[:domain_name].downcase).first

    if @site.nil?
      @site = @customer.sites.new(domain_name: params[:domain_name])
    end

    if @site.confirmed? && @site.secret_key == params[:secret_key]
      render status: 400, json: { code: 22, message: "The site has already been confirmed." }
      return
    end

    @site.unconfirmed_secret_key = params[:secret_key]
    if @site.save
      @site.send_confirmation_instructions
      render status: 200, json: { domain_name: @site.domain_name }
    else
      render status: 400, json: { code: 2, message: "An error occured.", errors: @site.errors.full_messages }
    end
  end

end

