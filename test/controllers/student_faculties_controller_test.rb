require 'test_helper'

class StudentFacultiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @student_faculty = student_faculties(:one)
  end

  test "should get index" do
    get student_faculties_url
    assert_response :success
  end

  test "should get new" do
    get new_student_faculty_url
    assert_response :success
  end

  test "should create student_faculty" do
    assert_difference('StudentFaculty.count') do
      post student_faculties_url, params: { student_faculty: { faculty_id: @student_faculty.faculty_id, student_id: @student_faculty.student_id } }
    end

    assert_redirected_to student_faculty_url(StudentFaculty.last)
  end

  test "should show student_faculty" do
    get student_faculty_url(@student_faculty)
    assert_response :success
  end

  test "should get edit" do
    get edit_student_faculty_url(@student_faculty)
    assert_response :success
  end

  test "should update student_faculty" do
    patch student_faculty_url(@student_faculty), params: { student_faculty: { faculty_id: @student_faculty.faculty_id, student_id: @student_faculty.student_id } }
    assert_redirected_to student_faculty_url(@student_faculty)
  end

  test "should destroy student_faculty" do
    assert_difference('StudentFaculty.count', -1) do
      delete student_faculty_url(@student_faculty)
    end

    assert_redirected_to student_faculties_url
  end
end
