require "test_helper"

class UserTest < ActiveSupport::TestCase
  test 'save empty data' do
    tester = User.new
    assert_not tester.save, 'Saved empty user'
  end

  test 'new data' do
    password = Faker::Lorem.word
    tester = User.new
    tester.email = Faker::Lorem.word
    tester.password = password
    tester.password_confirmation = password
    assert tester.save
  end

  test 'find data' do
    password = Faker::Lorem.word
    email = Faker::Lorem.word
    user = User.create(email: email, password: password, password_confirmation: password)
    res = User.find_by_email(email)
    assert_equal res.email, email
  end
end
