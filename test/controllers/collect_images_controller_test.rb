require 'test_helper'

class CollectImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @collect_image = collect_images(:one)
  end

  test "should get index" do
    get collect_images_url
    assert_response :success
  end

  test "should get new" do
    get new_collect_image_url
    assert_response :success
  end

  test "should create collect_image" do
    assert_difference('CollectImage.count') do
      post collect_images_url, params: { collect_image: { image: @collect_image.image } }
    end

    assert_redirected_to collect_image_url(CollectImage.last)
  end

  test "should show collect_image" do
    get collect_image_url(@collect_image)
    assert_response :success
  end

  test "should get edit" do
    get edit_collect_image_url(@collect_image)
    assert_response :success
  end

  test "should update collect_image" do
    patch collect_image_url(@collect_image), params: { collect_image: { image: @collect_image.image } }
    assert_redirected_to collect_image_url(@collect_image)
  end

  test "should destroy collect_image" do
    assert_difference('CollectImage.count', -1) do
      delete collect_image_url(@collect_image)
    end

    assert_redirected_to collect_images_url
  end
end
