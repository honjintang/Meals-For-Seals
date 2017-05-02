class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
  end

  def new
    # @restaurant = Restaurant.create(name: params[:name])
  end

end
