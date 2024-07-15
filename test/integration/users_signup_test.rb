require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    email = "userisinvalid@invalid"
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "",
                                         email: email,
                                         password: "foo",
                                         password_confirmation: "bar", admin: true }
      }
    end
    assert_template 'users/new'
  end
  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: {
        user: {
          name: "Test User 1",
          email: "userfortesting@example.com",
          password: "password123",
          password_confirmation: "password123",
          admin: true}
      }
    end
    follow_redirect!
    assert_template 'users/show'
  end
end
