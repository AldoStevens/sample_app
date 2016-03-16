require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  
  def setup
  	@non_admin = User.create!(name: "Aldo", email: "user@valid.com", password: "foobar", password_confirmation: "foobar", activated: true, activated_at: Time.zone.now)
    @admin = User.create!(name: "Example", email: "example@valid.com", password: "foobar", password_confirmation: "foobar", activated: true, activated_at: Time.zone.now, admin: true)
    
    35.times do |index|
      User.create!(name: "Example Name #{index}", email: "example-#{index+1}@railstutorial.com", password: "secret")
    end
  end

 

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    # assert_select 'div.pagination'
    # first_page_of_users = User.paginate(page: 1)
    # first_page_of_users.each do |user|
    # assert_select 'a[href=?]', user_path(user), text: user.name
    #   unless user == @admin
        # assert_select 'a[href=?]', user_path(user), text: 'delete'
      # end
    # end
    # assert_difference 'User.count', -1 do
    # delete user_path(@non_admin)
    # end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    # get login_path
    # post login_path, session: { email: @user.email, password: 'foobar' }
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end

end
