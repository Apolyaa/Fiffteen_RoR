require "test_helper"

class SessionTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'unauthorized user will be redirected to login page' do
    get root_url
    assert_redirected_to controller: :session, action: :login
  end

  test 'user with incorrect credentials will be redirected to login page' do
    post session_create_url, params: { email: Faker::Lorem.word, password: Faker::Lorem.word }
    assert_redirected_to controller: :session, action: :login
  end

  test 'user with correct credentials will see the root' do
    password = Faker::Lorem.word
    user = User.create(email: Faker::Lorem.word, password: password, password_confirmation: password)
    post session_create_url, params: { email: user.email, password: password }
    assert_redirected_to controller: :fifteen, action: :main
  end

  test 'user will see the root after signing up' do
    username = Faker::Lorem.word
    password = Faker::Lorem.word
    post users_url, params: { user: { email: username, password: password, password_confirmation: password } }
    assert_redirected_to controller: :fifteen, action: :main
  end

  test 'user can logout' do
    password = Faker::Lorem.word
    user = User.create(email: Faker::Lorem.word, password: password, password_confirmation: password)
    post session_create_url, params: { email: user.email, password: password }
    get session_logout_url
    assert_redirected_to controller: :session, action: :login
  end
end
