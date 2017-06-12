class SubjectsController < ApplicationController
  before_action :authenticate_user!
  before_action(
    :set_subject,
    only: [
      :show,
      :edit,
      :update,
      :destroy
    ]
  )

  def index
    @subjects = Subject.all.page(params[:page]).per(PER_PAGE)
  end

  def show
  end

  def new
    @subject = Subject.new
  end

  def edit
  end

  def create
    @subject = Subject.new(subject_params)

    respond_to do |format|
      if @subject.save
        format.html do
          redirect_to(
            @subject,
            notice: 'Subject was successfully created.'
          )
        end
        format.json do
          render(
            :show,
            status: :created,
            location: @subject
          )
        end
      else
        format.html do
          render :new
        end
        format.json do
          render(
            json: @subject.errors,
            status: :unprocessable_entity
          )
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @subject.update(subject_params)
        format.html do
          redirect_to(
            @subject,
            notice: 'Subject was successfully updated.'
          )
        end
        format.json do
          render(
            :show,
            status: :ok,
            location: @subject
          )
        end
      else
        format.html do
          render :edit
        end
        format.json do
          render(
            json: @subject.errors,
            status: :unprocessable_entity
          )
        end
      end
    end
  end

  def destroy
    @subject.destroy
    respond_to do |format|
      format.html do
        redirect_to(
          subjects_url,
          notice: 'Subject was successfully destroyed.'
        )
      end
      format.json do
        head :no_content
      end
    end
  end

  private
    def set_subject
      @subject = Subject.find(params[:id])
    end

    def subject_params
      params.require(
        :subject
      ).permit(
        :name,
        :trade_id
      )
    end
end
