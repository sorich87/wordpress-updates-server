class Api::Customer::V1::BaseController < ActionController::Base
  respond_to :json

  before_filter :authenticate_customer!
end
