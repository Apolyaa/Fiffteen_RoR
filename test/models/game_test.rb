require "test_helper"

class GameTest < ActiveSupport::TestCase
  test 'save data' do
    tester = Game.new
    assert tester.save, 'Saved empty game data'
  end

  test 'new data' do
    email = Faker::Lorem.word
    tester = Game.new
    tester.player_id = email
    tester.game_date = Date.today
    tester.time_to_win = 12000
    tester.clicks_to_win = 12
    assert tester.save
  end

  test 'find data' do
    email = Faker::Lorem.word
    tester = Game.new
    tester.player_id = email
    tester.game_date = Date.today
    tester.time_to_win = 12000
    tester.clicks_to_win = 12
    tester.save
    res = Game.find_by_player_id(email)
    assert_equal res.player_id, email
    assert_equal res.time_to_win, 12000
    assert_equal res.clicks_to_win, 12
  end
end
