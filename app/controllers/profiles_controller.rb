class ProfilesController < ApplicationController
  

  def index
    query = User.ransack(email_cont: params[:query])
    @users = query.result(distinct: true)
  end

  def users
    query = User.ransack(email_cont: search_query)
    @users = query.result(distance: true)
  end

  def search_query
    params[:query]
  end
end
