class Api::Users::StudentsController < Api::ApiController

  def student_details
    p "this is method"
    @students = Student.all
    students = []
    @students.each do |student|
      students << student.to_hash
    end
    render_json(students)
  end

  private
   def render_json(students, message = "succsess", status = 200)
    unless students.blank?
      render(
          json:{
              data:        students,
              message:     message,
              status:      status
          }
        )
    else
      render(
          json:{
              message:    "No data",
              status:     204
          }
        )
    end
  end
end