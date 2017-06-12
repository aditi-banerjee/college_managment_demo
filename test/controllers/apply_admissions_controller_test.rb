require 'test_helper'

class ApplyAdmissionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @apply_admission = apply_admissions(:one)
  end

  test "should get index" do
    get apply_admissions_url
    assert_response :success
  end

  test "should get new" do
    get new_apply_admission_url
    assert_response :success
  end

  test "should create apply_admission" do
    assert_difference('ApplyAdmission.count') do
      post apply_admissions_url, params: { apply_admission: { address: @apply_admission.address, contact_number: @apply_admission.contact_number, date_of_birth: @apply_admission.date_of_birth, email: @apply_admission.email, first_name: @apply_admission.first_name, gender: @apply_admission.gender, last_name: @apply_admission.last_name, passing_year: @apply_admission.passing_year, percentage: @apply_admission.percentage, trade_id: @apply_admission.trade_id, user_id: @apply_admission.user_id } }
    end

    assert_redirected_to apply_admission_url(ApplyAdmission.last)
  end

  test "should show apply_admission" do
    get apply_admission_url(@apply_admission)
    assert_response :success
  end

  test "should get edit" do
    get edit_apply_admission_url(@apply_admission)
    assert_response :success
  end

  test "should update apply_admission" do
    patch apply_admission_url(@apply_admission), params: { apply_admission: { address: @apply_admission.address, contact_number: @apply_admission.contact_number, date_of_birth: @apply_admission.date_of_birth, email: @apply_admission.email, first_name: @apply_admission.first_name, gender: @apply_admission.gender, last_name: @apply_admission.last_name, passing_year: @apply_admission.passing_year, percentage: @apply_admission.percentage, trade_id: @apply_admission.trade_id, user_id: @apply_admission.user_id } }
    assert_redirected_to apply_admission_url(@apply_admission)
  end

  test "should destroy apply_admission" do
    assert_difference('ApplyAdmission.count', -1) do
      delete apply_admission_url(@apply_admission)
    end

    assert_redirected_to apply_admissions_url
  end
end
