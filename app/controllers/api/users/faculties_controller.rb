class Api::Users::FacultiesController < Api::ApiController

  def faculty_details
    p "this is method"
    @faculties = Faculty.all
    faculties = []
    @faculties.each do |faculty|
      faculties << faculty.hash_data
    end
    render_json(faculties)
  end

  private
   def render_json(faculties, message = "succsess", status = 200)
    unless faculties.blank?
      render(
          json:{
              data:        faculties,
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