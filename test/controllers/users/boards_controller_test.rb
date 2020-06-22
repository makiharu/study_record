require 'test_helper'

class Users::BoardsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get users_boards_new_url
    assert_response :success
  end

  test "should get index" do
    get users_boards_index_url
    assert_response :success
  end

  test "should get show" do
    get users_boards_show_url
    assert_response :success
  end

  test "should get edit" do
    get users_boards_edit_url
    assert_response :success
  end

end
