require 'test_helper'

class ExamSchedulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @exam_schedule = exam_schedules(:one)
  end

  test "should get index" do
    get exam_schedules_url
    assert_response :success
  end

  test "should get new" do
    get new_exam_schedule_url
    assert_response :success
  end

  test "should create exam_schedule" do
    assert_difference('ExamSchedule.count') do
      post exam_schedules_url, params: { exam_schedule: { exam_date: @exam_schedule.exam_date, exam_time: @exam_schedule.exam_time, semester: @exam_schedule.semester, trade_id: @exam_schedule.trade_id } }
    end

    assert_redirected_to exam_schedule_url(ExamSchedule.last)
  end

  test "should show exam_schedule" do
    get exam_schedule_url(@exam_schedule)
    assert_response :success
  end

  test "should get edit" do
    get edit_exam_schedule_url(@exam_schedule)
    assert_response :success
  end

  test "should update exam_schedule" do
    patch exam_schedule_url(@exam_schedule), params: { exam_schedule: { exam_date: @exam_schedule.exam_date, exam_time: @exam_schedule.exam_time, semester: @exam_schedule.semester, trade_id: @exam_schedule.trade_id } }
    assert_redirected_to exam_schedule_url(@exam_schedule)
  end

  test "should destroy exam_schedule" do
    assert_difference('ExamSchedule.count', -1) do
      delete exam_schedule_url(@exam_schedule)
    end

    assert_redirected_to exam_schedules_url
  end
end
