class FeesController < ApplicationController
  before_action :authenticate_user!
  before_action(
    :set_fee,
    only: [
      :show,
      :edit,
      :update,
      :destroy
    ]
  )

  def index
    @fees = Fee.all.page(params[:page]).per(PER_PAGE)
  end

  def show
  end

  def new
    if current_user.admin?
      @fee = Fee.new
    end
  end

  def edit
  end

  def create
    if current_user.admin?
      @fee = Fee.new(fee_params)

      respond_to do |format|
        if @fee.save
          format.html do
            redirect_to(
              @fee,
              notice: 'Fee was successfully created.'
            )
          end
          format.json do
            render(
              :show,
              status: :created,
              location: @fee
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
              json: @fee.errors,
              status: :unprocessable_entity
            )
          end
        end
      end
    end
  end

  def update
    if current_user.admin?
      respond_to do |format|
        if @fee.update(fee_params)
          format.html do
            redirect_to(
              @fee,
              notice: 'Fee was successfully updated.'
            )
          end
          format.json do
            render(
              :show,
              status: :ok,
              location: @fee
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
              json: @fee.errors,
              status: :unprocessable_entity
            )
          end
        end
      end
    end
  end

  def destroy
    if current_user.admin?
      @fee.destroy
      respond_to do |format|
        format.html do
          redirect_to(
            fees_url,
            notice: 'Fee was successfully destroyed.'
          )
        end
        format.json do
          head :no_content
        end
      end
    end
  end

  private
    def set_fee
      @fee = Fee.find(params[:id])
    end

    def fee_params
      params.require(:fee).permit(
        :duration,
        :amount
      )
    end
end
