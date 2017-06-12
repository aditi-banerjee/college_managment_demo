class StudentFacultiesController < ApplicationController
  before_action :authenticate_user!
  before_action(
    :set_student_faculty,
    only: [
      :show,
      :edit,
      :update,
      :destroy
    ]
  )

  def index
    @student_faculties = StudentFaculty.all.page(params[:page]).per(PER_PAGE)
  end

  def show
  end

  def new
    if current_user.admin?
      @student_faculty = StudentFaculty.new
    end
  end

  def edit
  end

  def create
    if current_user.admin?
      @student_faculty = StudentFaculty.new(student_faculty_params)
      respond_to do |format|
        if @student_faculty.save
          format.html do
            redirect_to(
              @student_faculty,
              notice: 'Student faculty was successfully created.'
            )
          end
          format.json do
            render(
              :show,
              status: :created,
              location: @student_faculty
            )
          end
        else
          format.html do
            render :new
          end
          format.json
            render(
              json: @student_faculty.errors,
              status: :unprocessable_entity
            )
        end
      end
    end
  end

  def update
    if current_user.admin?
      respond_to do |format|
        if @student_faculty.update(student_faculty_params)
          format.html do
            redirect_to(
              @student_faculty,
              notice: 'Student faculty was successfully updated.'
            )
          end
          format.json do
            render(
              :show,
              status: :ok,
              location: @student_faculty
            )
          end
        else
          format.html do
            render(
              :edit
            )
          end
          format.json do
            render(
              json: @student_faculty.errors,
              status: :unprocessable_entity
            )
          end
        end
      end
    end
  end

  def destroy
    if current_user.admin?
      @student_faculty.destroy
      respond_to do |format|
        format.html do
          redirect_to(
            student_faculties_url,
            notice: 'Student faculty was successfully destroyed.'
          )
        end
        format.json do
          head :no_content
        end
      end
    end
  end

  private
    def set_student_faculty
      @student_faculty = StudentFaculty.find(params[:id])
    end

    def student_faculty_params
      params.require(:student_faculty).permit(
        :student_id,
        :faculty_id
      )
    end
end
