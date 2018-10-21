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

end
