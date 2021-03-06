class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/new'
    else
      redirect to '/games'
    end
  end

  post '/signup' do
    if params[:username] == '' || params[:password] == ''
      redirect to '/signup'
    elsif User.find_by(:username => params[:username]) != nil
      redirect to '/signup'
    else
      @user = User.create(username: params[:username], password: params[:password])
      session[:user_id] = @user.id
      redirect to '/games'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/games'
    end
  end

  post '/login' do
  	@user = User.find_by(username: params[:username])
  	if @user && @user.authenticate(params[:password])
  		session[:user_id] = @user.id
  		redirect to '/games'
  	else
  		redirect to '/signup'
  	end
  end

  get '/users/:id' do
		@user = User.find_by_id(params[:id])
		erb :'users/show'
	end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end
