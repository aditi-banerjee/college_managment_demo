require 'test_helper'

class UploadFeeStructuresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @upload_fee_structure = upload_fee_structures(:one)
  end

  test "should get index" do
    get upload_fee_structures_url
    assert_response :success
  end

  test "should get new" do
    get new_upload_fee_structure_url
    assert_response :success
  end

  test "should create upload_fee_structure" do
    assert_difference('UploadFeeStructure.count') do
      post upload_fee_structures_url, params: { upload_fee_structure: { fail_error: @upload_fee_structure.fail_error, number_of_fail: @upload_fee_structure.number_of_fail, number_of_success: @upload_fee_structure.number_of_success, status: @upload_fee_structure.status, total_record: @upload_fee_structure.total_record, upload: @upload_fee_structure.upload, user_id: @upload_fee_structure.user_id } }
    end

    assert_redirected_to upload_fee_structure_url(UploadFeeStructure.last)
  end

  test "should show upload_fee_structure" do
    get upload_fee_structure_url(@upload_fee_structure)
    assert_response :success
  end

  test "should get edit" do
    get edit_upload_fee_structure_url(@upload_fee_structure)
    assert_response :success
  end

  test "should update upload_fee_structure" do
    patch upload_fee_structure_url(@upload_fee_structure), params: { upload_fee_structure: { fail_error: @upload_fee_structure.fail_error, number_of_fail: @upload_fee_structure.number_of_fail, number_of_success: @upload_fee_structure.number_of_success, status: @upload_fee_structure.status, total_record: @upload_fee_structure.total_record, upload: @upload_fee_structure.upload, user_id: @upload_fee_structure.user_id } }
    assert_redirected_to upload_fee_structure_url(@upload_fee_structure)
  end

  test "should destroy upload_fee_structure" do
    assert_difference('UploadFeeStructure.count', -1) do
      delete upload_fee_structure_url(@upload_fee_structure)
    end

    assert_redirected_to upload_fee_structures_url
  end
end
