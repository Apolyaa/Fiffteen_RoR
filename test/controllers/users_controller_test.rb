require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest

  test 'unauthorized user will be redirected to login page' do
    get root_url
    assert_redirected_to controller: :session, action: :login
  end

  test 'user with correct credentials can get user list' do
    password = Faker::Lorem.word
    user = User.create(email: Faker::Lorem.word, password: password, password_confirmation: password)
    post session_create_url, params: { email: user.email, password: password }
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_path
    assert_response :success
  end

  test "should create user and redirect to main page" do
    email = Faker::Lorem.word
    password = Faker::Lorem.word
    assert_difference('User.count') do
      post users_url, params: { user: { email: email, password: password, password_confirmation: password } }
    end

    assert_redirected_to fifteen_main_url
  end

  test "user with correct credentials can get user page" do
    password = Faker::Lorem.word
    user = User.create(email: Faker::Lorem.word, password: password, password_confirmation: password)
    post session_create_url, params: { email: user.email, password: password } 
    get user_url(user)
    assert_response :success
  end

  # test "should get edit" do
  #   get edit_user_url(@user)
  #   assert_response :success
  # end

  # test "should update user" do
  #   patch user_url(@user), params: { user: { email: @user.email } }
  #   assert_redirected_to user_url(@user)
  # end

  # test "should destroy user" do
  #   assert_difference('User.count', -1) do
  #     delete user_url(@user)
  #   end

  #   assert_redirected_to users_url
  # end
end
