require 'test_helper'

class Public::BoardCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_board_comments_index_url
    assert_response :success
  end

  test "should get edit" do
    get public_board_comments_edit_url
    assert_response :success
  end

end
