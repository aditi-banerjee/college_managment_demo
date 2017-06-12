require 'test_helper'

class CollageImagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get collage_images_index_url
    assert_response :success
  end

  test "should get create" do
    get collage_images_create_url
    assert_response :success
  end

end
