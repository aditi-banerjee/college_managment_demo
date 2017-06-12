class ApplyAdmissionsController < ApplicationController
  before_action :authenticate_user!
  before_action(
    :set_apply_admission,
    only: [
      :show,
      :edit,
      :update,
      :destroy
    ]
  )

  def index
    if current_user.admin?
      @search_r = Sunspot.search [ApplyAdmission] do
        keywords params[:search]
      end
      if @search_r.results.any?
        @apply_admissions = @search_r.results
      else
        @apply_admissions = ApplyAdmission.all.paginate(page: params[:page]).per(PER_PAGE)
      end
    elsif current_user.user?
      @apply_admissions = ApplyAdmission.where("user_id = ?", current_user.id).paginate(page: params[:page]).per(PER_PAGE)
    end
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Application details",   # Excluding ".pdf" extension.
               file:         "apply_admissions/show.pdf.erb"
      end
    end
  end

  def new
    if(
      ApplyAdmission.exists?(user_id: current_user.id) ||
      !current_user.user?
    )
      redirect_to home_path
    elsif current_user.user?
      @apply_admission = ApplyAdmission.new
    end
  end

  def edit
  end

  def create
    @apply_admission = ApplyAdmission.new(apply_admission_params)
    Cloudinary::Uploader.upload(params[:apply_admission][:result],
                            # :public_id => "sample_id",
                            :crop => :limit, :width => 2000, :height => 2000,
                            :eager => [
                              { :width => 200, :height => 200, 
                                :crop => :thumb, :gravity => :face,
                                :radius => 20, :effect => :sepia },
                              { :width => 100, :height => 150, 
                                :crop => :fit, :format => 'png' }
                            ],                                     
                            :tags => ['special', 'for_homepage'])
    @apply_admission.user_id = current_user.id
    @apply_admission.email = current_user.email
    respond_to do |format|
      if @apply_admission.save
        format.html do
          redirect_to(
            @apply_admission,
            notice: 'Apply admission was successfully created.'
          )
        end
        format.json do
          render(
            :show,
            status: :created,
            location: @apply_admission
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
            json: @apply_admission.errors,
            status: :unprocessable_entity
          )
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @apply_admission.update(apply_admission_params)
        format.html do
          redirect_to(
            @apply_admission,
            notice: 'Apply admission was successfully updated.'
          )
        end
        format.json do
          render(
            :show,
            status: :ok,
            location: @apply_admission
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
            json: @apply_admission.errors,
            status: :unprocessable_entity
          )
        end
      end
    end
  end

  def destroy
    @apply_admission.destroy
    respond_to do |format|
      format.html do
        redirect_to(
          apply_admissions_url,
          notice: 'Apply admission was successfully destroyed.'
        )
      end
      format.json do
        head :no_content
      end
    end
  end

  def approved
    @apply_admission = ApplyAdmission.find_by_id(params[:apply_admission_id])
      if ApplyAdmission.exists?(id: @apply_admission)
      if @apply_admission.update(approve: true,reject: false ,approve_by: current_user.id)
        respond_to do |format|
          format.html do
            redirect_to(
              apply_admission_path(@apply_admission),
              notice: 'Apply Admission was successfully updated.'
            )
          end
          format.json do
            render(
              :show,
              status: :ok,
              location: @apply_admission
            )
          end
        end
      end
    end
  end

  def reject_application
    @apply_admission = ApplyAdmission.find_by_id(params[:apply_admission_id])
      if ApplyAdmission.exists?(id: @apply_admission)
      if @apply_admission.update(approve: false,reject: true ,reject_by: current_user.id)
        respond_to do |format|
          format.html do
            redirect_to(
              apply_admission_path(@apply_admission),
              notice: 'Sorry your application was rejected updated.'
            )
          end
          format.json do
            render(
              :show,
              status: :ok,
              location: @apply_admission
            )
          end
        end
      end
    end
  end

  def confirmation
    @apply_admission = ApplyAdmission.find_by_id(params[:apply_admission_id])
    @user = User.find(@apply_admission.user_id)

    StudentMailer.confirmation_send(@apply_admission, @user).deliver_now
    flash[:notice] = "Confirmation has been sent."
    redirect_to apply_admissions_path
  end

  private
    def set_apply_admission
      @apply_admission = ApplyAdmission.find(params[:id])
    end

    def apply_admission_params
      params.require(:apply_admission).permit(
        :first_name,
        :last_name,
        :gender,
        :email,
        :contact_number,
        :address,
        :trade_id,
        :percentage,
        :date_of_birth,
        :passing_year,
        :user_id,
        :image,
        :result,
        :student_certificate
      )
    end
end
