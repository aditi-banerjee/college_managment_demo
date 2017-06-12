require 'test_helper'

class ApplyJobsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @apply_job = apply_jobs(:one)
  end

  test "should get index" do
    get apply_jobs_url
    assert_response :success
  end

  test "should get new" do
    get new_apply_job_url
    assert_response :success
  end

  test "should create apply_job" do
    assert_difference('ApplyJob.count') do
      post apply_jobs_url, params: { apply_job: { address: @apply_job.address, contact_number: @apply_job.contact_number, date_of_birth: @apply_job.date_of_birth, email: @apply_job.email, first_name: @apply_job.first_name, gender: @apply_job.gender, last_name: @apply_job.last_name, passing_year: @apply_job.passing_year, percentage: @apply_job.percentage, qualification: @apply_job.qualification, trade_id: @apply_job.trade_id, user_id: @apply_job.user_id } }
    end

    assert_redirected_to apply_job_url(ApplyJob.last)
  end

  test "should show apply_job" do
    get apply_job_url(@apply_job)
    assert_response :success
  end

  test "should get edit" do
    get edit_apply_job_url(@apply_job)
    assert_response :success
  end

  test "should update apply_job" do
    patch apply_job_url(@apply_job), params: { apply_job: { address: @apply_job.address, contact_number: @apply_job.contact_number, date_of_birth: @apply_job.date_of_birth, email: @apply_job.email, first_name: @apply_job.first_name, gender: @apply_job.gender, last_name: @apply_job.last_name, passing_year: @apply_job.passing_year, percentage: @apply_job.percentage, qualification: @apply_job.qualification, trade_id: @apply_job.trade_id, user_id: @apply_job.user_id } }
    assert_redirected_to apply_job_url(@apply_job)
  end

  test "should destroy apply_job" do
    assert_difference('ApplyJob.count', -1) do
      delete apply_job_url(@apply_job)
    end

    assert_redirected_to apply_jobs_url
  end
end
