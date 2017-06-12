class ApplyJobsController < ApplicationController
  before_action :authenticate_user!
  before_action(
    :set_apply_job,
    only: [
      :show,
      :edit,
      :update,
      :destroy
    ]
  )

  def index
    if current_user.admin?
      @apply_jobs = ApplyJob.all.page(params[:page]).per(PER_PAGE)
    elsif current_user.user?
      @apply_jobs = ApplyJob.where("user_id = ?", current_user.id).page(params[:page]).per(PER_PAGE)
    end
  end

  def show
     @uploads = JobCertificate.order('apply_job_id ASC')
  end

  def new
    if(
      ApplyJob.exists?(user_id: current_user.id) ||
      !current_user.user?
    )
      redirect_to home_path
    elsif current_user.user?
      @apply_job = ApplyJob.new
    end
  end

  def edit
  end

  def create
    @apply_job = ApplyJob.new(apply_job_params)
    @apply_job.user_id = current_user.id
    @apply_job.email = current_user.email
    respond_to do |format|
      if @apply_job.save
        format.html do
          redirect_to(
            @apply_job,
            notice: 'Apply job was successfully created.'
          )
        end
        format.json do
          render(
            :show,
            status: :created,
            location: @apply_job
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
            json: @apply_job.errors,
            status: :unprocessable_entity
          )
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @apply_job.update(apply_job_params)
        format.html do
          redirect_to(
            @apply_job,
            notice: 'Apply job was successfully updated.'
          )
        end
        format.json do
          render(
            :show,
            status: :ok,
            location: @apply_job
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
            json: @apply_job.errors,
            status: :unprocessable_entity
          )
        end
      end
    end
  end

  def destroy
    @apply_job.destroy
    respond_to do |format|
      format.html do
        redirect_to(
          apply_jobs_url,
          notice: 'Apply job was successfully destroyed.'
        )
      end
      format.json do
        head :no_content
      end
    end
  end

  def approved
    @apply_job = ApplyJob.find_by_id(params[:apply_job_id])
      if ApplyJob.exists?(id: @apply_job)
      if @apply_job.update(approve: true,reject: false ,approve_by: current_user.id)
        respond_to do |format|
          format.html do
            redirect_to(
              apply_job_path(@apply_job),
              notice: 'Job Application was successfully updated.'
            )
          end
          format.json do
            render(
              :show,
              status: :ok,
              location: @apply_job
            )
          end
        end
      end
    end
  end

  def reject_application
    @apply_job = ApplyJob.find_by_id(params[:apply_job_id])
      if ApplyJob.exists?(id: @apply_job)
      if @apply_job.update(approve: false,reject: true ,rejected_by: current_user.id)
        respond_to do |format|
          format.html do
            redirect_to(
              apply_job_path(@apply_job),
              notice: 'Sorry your application was rejected.'
            )
          end
          format.json do
            render(
              :show,
              status: :ok,
              location: @apply_job
            )
          end
        end
      end
    end
  end

  def confirmation
    @apply_job = ApplyJob.find_by_id(params[:apply_job_id])
    @user = User.find(@apply_job.user_id)

    FacultyMailer.job_confirmation(@apply_job, @user).deliver
    flash[:notice] = "Confirmation has been sent."
    redirect_to apply_jobs_path
  end

  private
    def set_apply_job
      @apply_job = ApplyJob.find(params[:id])
    end

    def apply_job_params
      params.require(:apply_job).permit(
        :first_name,
        :last_name,
        :gender,
        :email,
        :contact_number,
        :address,
        :trade_id,
        :percentage,
        :qualification,
        :date_of_birth,
        :passing_year,
        :user_id,
        :document,
        job_certificates_attributes:[
          :title,
          :certificate
        ]
      )
    end
end
