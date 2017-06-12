class TradeFeesController < ApplicationController
  before_action :authenticate_user!
  before_action(
    :set_trade_fee,
    only: [
      :show,
      :edit,
      :update,
      :destroy
    ]
  )

  def index
    @trade_fees = TradeFee.all.page(params[:page]).per(PER_PAGE)
  end

  def show
  end

  def new
    if current_user.admin?
      @trade_fee = TradeFee.new
    end
  end

  def edit
  end

  def create
    if current_user.admin?
      @trade_fee = TradeFee.new(trade_fee_params)
      respond_to do |format|
        if @trade_fee.save
          format.html do
            redirect_to(
              @trade_fee,
              notice: 'Trade fee was successfully created.'
            )
          end
          format.json do
            render(
              :show,
              status: :created,
              location: @trade_fee
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
              json: @trade_fee.errors,
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
        if @trade_fee.update(trade_fee_params)
          format.html do
            redirect_to(
              @trade_fee,
              notice: 'Trade fee was successfully updated.'
            )
          end
          format.json do
            render(
              :show,
              status: :ok,
              location: @trade_fee
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
              json: @trade_fee.errors,
              status: :unprocessable_entity
            )
          end
        end
      end
    end
  end

  def destroy
    if current_user.admin?
      @trade_fee.destroy
      respond_to do |format|
        format.html do
          redirect_to(
            trade_fees_url,
            notice: 'Trade fee was successfully destroyed.'
          )
        end
        format.json do
          head :no_content
        end
      end
    end
  end

  private
    def set_trade_fee
      @trade_fee = TradeFee.find(params[:id])
    end

    def trade_fee_params
      params.require(:trade_fee).permit(
        :trade_id,
        :fee_id
      )
    end
end
