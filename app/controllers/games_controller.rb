class GamesController < ApplicationController

  get '/games' do
    if logged_in?
      @user = current_user
      @games = Game.all
      erb :'games/games'
    else
      redirect '/login'
    end
  end

  get '/games/new' do
    if logged_in?
      @games = Game.all
      erb :'games/new'
    else
      redirect '/login'
    end
  end

  post '/games' do
    if params[:name] == ''
      redirect to '/games/new'
    else
      game = Game.create(name: params[:name], year: params[:year], designer: params[:designer])
      game.user = current_user
      game.save
      redirect '/games'
    end
  end

  get '/games/:id' do
    if logged_in?
      @game = Game.find_by_id(params[:id])
      erb :'games/show'
    else
      redirect '/login'
    end
  end

  get '/games/:id/edit' do
   @game = Game.find_by_id(params[:id])
    if logged_in?
        erb :'/games/edit_game'
    elsif logged_in?
        redirect '/games'
    else
        redirect '/login'
    end
  end

  patch '/games/:id' do
    @game = Game.find_by(params[:id])
    @user = User.find_by(id: session[:user_id])
    if logged_in? && @user.games.include?(@game) && !params["game"]["name"].empty?
      @game.update(name: params["game"]["name"])
      @game.save
      redirect to "/games/#{@game.id}"
    else
      redirect to "/games/#{@game.id}/edit"
    end
  end

end
