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

end
