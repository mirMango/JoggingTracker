class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:about]
  def about
  end
end
