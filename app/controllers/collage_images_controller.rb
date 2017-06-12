class CollageImagesController < ApplicationController
  before_action :authenticate_user!
  def index
    @collage_images = CollageImage.all
    @collage_image = CollageImage.new
  end

  def create
    @collage_image = CollageImage.new(collage_image_params)

    if @collage_image.save
      render json: { message: "success", fileID: @collage_image.id }, status: 200
    else
      render json: { error: @collage_image.errors.full_messages.join(',')}, status: 400
    end
  end

private

  def collage_image_params
    params.require(:collage_image).permit(:image)
  end
end
