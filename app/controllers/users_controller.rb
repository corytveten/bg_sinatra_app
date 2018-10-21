class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/new'
    else
      redirect to '/games'
    end
  end

  post '/signup' do
    if logged_in?
      redirect to '/games'
    elsif params[:username] == '' || params[:password] == ''
      redirect to '/signup'
    else
      @user = User.create(username: params[:username], password: params[:password])
      session[:user_id] = @user.id
      redirect to '/games'
    end
  end

  get '/login' do
    if !!logged_in?
      erb :'users/login'
    else
      redirect to '/games'
    end
  end

end
