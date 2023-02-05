require "test_helper"

class FifteenControllerTest < ActionDispatch::IntegrationTest
  test "get result and save in db" do
    def time_as_str(ms)
      secs, ms    =   ms.divmod(1000)
      mins, secs  = secs.divmod(60)
      hours, mins = mins.divmod(60)
      
      s = "%02d:%02d:%02d" % [hours, mins, secs]      
    end

    password = Faker::Lorem.word
    user = User.create(email: Faker::Lorem.word, password: password, password_confirmation: password)
    post session_create_url, params: { email: user.email, password: password }
    get fifteen_result_url, params:{click: '12', time: '12000'}
    assert_equal '12', assigns(:click)
    time = time_as_str('12000'.to_i)
    assert_equal time, assigns(:time)
    assert_equal Game.last.time_to_win.to_i, '12000'.to_i
    assert_equal Game.last.clicks_to_win, '12'.to_i
  end

  test "get data results" do
    def time_as_str(ms)
      secs, ms    =   ms.divmod(1000)
      mins, secs  = secs.divmod(60)
      hours, mins = mins.divmod(60)
      
      s = "%02d:%02d:%02d" % [hours, mins, secs]      
    end
    password = Faker::Lorem.word
    email = Faker::Lorem.word
    user = User.create(email: email, password: password, password_confirmation: password)
    post session_create_url, params: { email: user.email, password: password }
    
    tester = Game.new
    tester.player_id = email
    tester.game_date = Date.today
    tester.time_to_win = 12000
    tester.clicks_to_win = 12
    tester.save
    tester = Game.new
    tester.player_id = email
    tester.game_date = Date.today
    tester.time_to_win = 13000
    tester.clicks_to_win = 13
    tester.save
    tester = Game.new
    tester.player_id = email
    tester.game_date = Date.today
    tester.time_to_win = 14000
    tester.clicks_to_win = 14
    tester.save
    get fifteen_data_url
    assert_equal [Date.today.strftime('%d %B %Y'), Date.today.strftime('%d %B %Y'), Date.today.strftime('%d %B %Y')], assigns(:res_arr_date)
    assert_equal [time = time_as_str('12000'.to_i), time = time_as_str('13000'.to_i), time = time_as_str('14000'.to_i)], assigns(:res_arr_time)
    assert_equal [12, 13, 14], assigns(:res_arr_clicks)
    assert_equal 0, assigns(:min_time)
    assert_equal 0, assigns(:min_clicks)
  end

  test "get data error" do
    password = Faker::Lorem.word
    email = Faker::Lorem.word
    user = User.create(email: email, password: password, password_confirmation: password)
    post session_create_url, params: { email: user.email, password: password }
    get fifteen_data_url
    assert_equal 'Записей пока нет', assigns(:error)
  end
end
