# frozen_string_literal: true

require 'date'
class FifteenController < ApplicationController
  def main; end

  def input; end

  def game
    @game_mode = params[:game_mode]
  end

  def result
    @click = params[:click]
    tmpTime = params[:time]
    @time = time_as_str(tmpTime.to_i)
    remember_token = User.encrypt(cookies[:remember_token])
    current_user ||= User.find_by_remember_token(remember_token)
    current_user_login = current_user.email
    if !tmpTime.nil? && !@click.nil?
      Game.create player_id: current_user_login, game_date: Date.today, time_to_win: tmpTime, clicks_to_win: @click
    end
  end

  def data
    arr_date = []
    arr_time = []
    arr_clicks = []
    remember_token = User.encrypt(cookies[:remember_token])
    current_user ||= User.find_by_remember_token(remember_token)
    current_user_login = current_user.email
    Game.where(player_id: current_user_login).find_each do |game|
      arr_date << game.game_date.strftime('%d %B %Y') unless game.game_date.nil?
      arr_time << time_as_str(game.time_to_win) unless game.time_to_win.nil?
      arr_clicks << game.clicks_to_win unless game.clicks_to_win.nil?
    end
    if !arr_date.empty?
      @res_arr_date = arr_date
      @res_arr_time = arr_time
      @res_arr_clicks = arr_clicks
      @min_time = arr_time.index(arr_time.min)
      @min_clicks = arr_clicks.index(arr_clicks.min)
    else
      @error = 'Записей пока нет'
    end
  end

  def time_as_str(ms)
    secs, ms = ms.divmod(1000)
    mins, secs  = secs.divmod(60)
    hours, mins = mins.divmod(60)

    s = format('%02d:%02d:%02d', hours, mins, secs)
  end
end
