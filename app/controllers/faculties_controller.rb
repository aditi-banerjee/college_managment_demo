class FacultiesController < ApplicationController
  before_action(
    :set_faculty,
    only: [
      :show,
      :edit,
      :update,
      :destroy
    ]
  )

  def index
    if current_user.admin?
      @faculties = Faculty.search_for(params[:search]).all.page(params[:page]).per(PER_PAGE)
    elsif current_user.faculty?
      @faculties = Faculty.search_for(params[:search]).where("user_id = ?", current_user.id).page(params[:page]).per(PER_PAGE)
    end
  end

  def show
  end

  def new
    if Faculty.exists?(user_id: current_user.id)
      redirect_to home_path
    else
      @faculty = Faculty.new
    end
  end

  def edit
  end

  def create
    unless Faculty.exists?(user_id: current_user.id)
      @faculty = Faculty.new(faculty_params)
      @faculty.user_id = current_user.id
      @faculty.email   = current_user.email
      respond_to do |format|
        if @faculty.save
          format.html do
            redirect_to(
              @faculty,
              notice: 'Faculty was successfully created.'
            )
          end
          format.json do
            render(
              :show,
              status: :created,
              location: @faculty
            )
          end
        else
          format.html do
            render :new
          end
          format.json do
            render(
              json: @faculty.errors,
              status: :unprocessable_entity
            )
          end
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @faculty.update(faculty_params)
        format.html do
          redirect_to(
            @faculty,
            notice: 'Faculty was successfully updated.'
          )
        end
        format.json do 
          render(
            :show,
            status: :ok,
            location: @faculty
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
            json: @faculty.errors,
            status: :unprocessable_entity
          )
        end
      end
    end
  end

  def destroy
    @faculty.destroy
    respond_to do |format|
      format.html do 
        redirect_to(
          faculties_url,
          notice: 'Faculty was successfully destroyed.'
        )
      end
      format.json do
        head :no_content
      end
    end
  end

  private
    def set_faculty
      @faculty = Faculty.find(params[:id])
    end

    def faculty_params
      params.require(:faculty).permit(
        :user_id,
        :first_name,
        :last_name,
        :date_of_birth,
        :date_of_join,
        :trade_id,
        :gender,
        :address,
        :salary,
        :email,
        :mobile_no
      )
    end
end
