class HomeController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:sorry]

  def index
  end

  def sorry
  end
end
