class TradesController < ApplicationController
  before_action :authenticate_user!
  before_action(
    :set_trade,
    only: [
      :show,
      :edit,
      :update,
      :destroy
    ]
  )

  def index
    @search_r = Sunspot.search [Trade] do
      fulltext params[:search]
    end
    if @search_r.results.any?
      @trades = @search_r.results
    else
      @trades = Trade.all.page(params[:page]).per(PER_PAGE)
    end
  end

  def show
  end

  def new
    if current_user.admin?
      @trade = Trade.new
    end
  end

  def edit
  end

  def create
    @trade = Trade.new(trade_params)
    respond_to do |format|
      if @trade.save
        format.html do
          redirect_to(
            @trade,
            notice: 'Trade was successfully created.'
          )
        end
        format.json do
          render(
            :show,
            status: :created,
            location: @trade
          )
        end
      else
        format.html do
          render :new
        end
        format.json do
          render(
            json: @trade.errors,
            status: :unprocessable_entity
          )
        end
      end
    end
  end

  def update
    if current_user.admin?
      respond_to do |format|
        if @trade.update(trade_params)
          format.html do
            redirect_to(
              @trade,
              notice: 'Trade was successfully updated.'
            )
          end
          format.json do
            render(
              :show,
              status: :ok,
              location: @trade
            )
          end
        else
          format.html do
            render :edit
          end
          format.json do
            render(
              json: @trade.errors,
              status: :unprocessable_entity
            )
          end
        end
      end
    end
  end

  def destroy
    if current_user.admin?
      @trade.destroy
      respond_to do |format|
        format.html do
          redirect_to(
            trades_url,
            notice: 'Trade was successfully destroyed.'
            )
        end
        format.json do
          head :no_content
        end
      end
    end
  end

  private

    def set_trade
      @trade = Trade.find(params[:id])
    end

    def trade_params
      params.require(:trade).permit(
        :name,
        :trade_duration
      )
    end
end
