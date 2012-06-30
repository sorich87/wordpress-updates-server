class HomeController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:sorry]

  def index
  end

  def sorry
  end

  def tour
    return unless params[:end] == 'yes'
    @business.update_attribute('tour', 'no')
    render nothing: true
  end
end
