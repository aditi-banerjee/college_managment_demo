class CollectImagesController < ApplicationController
  before_action :set_collect_image, only: [:show, :edit, :update, :destroy]

  # GET /collect_images
  # GET /collect_images.json
  def index
    @collect_images = CollectImage.all
  end

  # GET /collect_images/1
  # GET /collect_images/1.json
  def show
  end

  # GET /collect_images/new
  def new
    @collect_image = CollectImage.new
  end

  # GET /collect_images/1/edit
  def edit
  end

  # POST /collect_images
  # POST /collect_images.json
  def create
    @collect_image = CollectImage.new(collect_image_params)

    respond_to do |format|
      if @collect_image.save
        format.html { redirect_to @collect_image, notice: 'Collect image was successfully created.' }
        format.json { render :show, status: :created, location: @collect_image }
      else
        format.html { render :new }
        format.json { render json: @collect_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collect_images/1
  # PATCH/PUT /collect_images/1.json
  def update
    respond_to do |format|
      if @collect_image.update(collect_image_params)
        format.html { redirect_to @collect_image, notice: 'Collect image was successfully updated.' }
        format.json { render :show, status: :ok, location: @collect_image }
      else
        format.html { render :edit }
        format.json { render json: @collect_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collect_images/1
  # DELETE /collect_images/1.json
  def destroy
    @collect_image.destroy
    respond_to do |format|
      format.html { redirect_to collect_images_url, notice: 'Collect image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collect_image
      @collect_image = CollectImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def collect_image_params
      params.require(:collect_image).permit(:image)
    end
end
