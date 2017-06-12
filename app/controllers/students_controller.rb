class StudentsController < ApplicationController
  before_action :authenticate_user!
  before_action(
    :set_student,
    only: [
      :show,
      # :add_image,
      :edit,
      :update,
      :destroy
    ]
  )

  def search
    Student.search do
      fulltext params[:search]
    end
  end

  def index
    conditions = ['']
    @search = params[:search]
      conditions[0] << '(first_name like ? or last_name like ?)'
      conditions << "%#{@search}%"
      conditions << "%#{@search}%"
    # if current_user.admin?
    #   @students = Student.where(conditions).page(params[:page]).per(PER_PAGE)
    if current_user.student?
      @students = Student.where("user_id= ?",current_user.id).where(conditions).page(params[:page]).per(PER_PAGE)
    end
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "students details",   # Excluding ".pdf" extension.
               file:         "students/show.pdf.erb"
      end
    end
  end

  def new
    if Student.exists?(user_id: current_user.id)
      redirect_to home_path
    else
      @student = Student.new
    end
  end

  def edit
  end

  def create
    unless Student.exists?(user_id: current_user.id)
      @student = Student.new(student_params)
      @student.user_id = current_user.id
      @student.email = current_user.email
      respond_to do |format|
        if @student.save
          format.html do
            redirect_to(
              @student,
              notice: 'Student was successfully created.'
              )
          end
          format.json do
            render(
              :show,
              status: :created,
              location: @student
            )
          end
        else
          format.html do
            render(
              :new
            )
          end
          format.json do
            render(
              json: @student.errors,
              status: :unprocessable_entity
            )
          end
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html do
          redirect_to(
            @student,
            notice: 'Student was successfully updated.'
          )
        end
        format.json do
          render(
            :show,
            status: :ok,
            location: @student
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
            json: @student.errors,
            status: :unprocessable_entity
          )
        end
      end
    end
  end

  def destroy
    @student.destroy
    respond_to do |format|
      format.html do
        redirect_to(
          students_url,
          notice: 'Student was successfully destroyed.'
        )
      end
      format.json do
        head :no_content
      end
    end
  end

#   def add_image
# p "-----------------------------"
# p params
# p "-----------------------------"
#     if @student.update(image: params[:image])
#       p "success========="
#     else
#       p @student.errors.messages
#     end
#   end

  private
    def set_student
      @student = Student.find(params[:id])
    end

    def student_params
      params.require(:student).permit(
        :user_id,
        :first_name,
        :last_name,
        :date_of_birth,
        :date_of_admission,
        :trade_id,
        :mobile_no,
        :gender,
        :address,
        :email,
        :image,
        :city
      )
    end
end
