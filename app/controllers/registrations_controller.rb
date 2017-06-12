class RegistrationsController < ApplicationController
  before_action(
    :set_registration,
    only: [
      :show,
      :edit,
      :update,
      :destroy
    ]
  )

  def index
    @registrations = Registration.all
  end

  def show
  end

  def new
    @registration = Registration.new
  end

  def edit
  end

  def create
    @registration = Registration.new(registration_params)
    if @registration.save
      redirect_to @registration.paypal_url(registration_path(@registration))
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @registration.update(registration_params)
        format.html do
          redirect_to(
            @registration,
            notice: 'Registration was successfully updated.'
          )
        end
        format.json do
          render(
            :show, status: :ok,
            location: @registration
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
            json: @registration.errors,
            status: :unprocessable_entity
          )
        end
      end
    end
  end

  def destroy
    @registration.destroy
    respond_to do |format|
      format.html { redirect_to registrations_url, notice: 'Registration was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_registration
      @registration = Registration.find(params[:id])
    end

    def registration_params
      params.require(:registration).permit(:trade_fees, :full_name, :email, :phone_no)
    end
end
