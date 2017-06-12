class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :edit, :update, :destroy]

  def index
    @collections = Collection.all
  end

  def show
  end

  def new
    @collection = Collection.new
  end

  def edit
  end

  def create
    puts "==================="
    p collection_params
    puts "======================"
    @collection = Collection.new(collection_params)
    p @collection
     zip_boolean = false
        folders = []
        unless params[:image].blank?
          params[:image][:file_name].each do |zip|
            if zip.content_type.to_s == 'application/zip'
              zip_boolean = true
            end
            if zip_boolean
              Zip::File.open(zip.tempfile) do |zip_file|
                counter = 0
                zip_file.each do |entry|
                  data = entry.extract ("#{Rails.root}/tmp/#{entry.name}"){ true }
                  dir = Rails.root.join('tmp', entry.name)
                  folders << dir
                  counter = counter + 1
                  if counter > 1
                    File.open(dir) do |f|
                      @collection.Collection.create(file_name: f)
                    end
                  end
                end
                counter = 0
              end
              folders.each do |folder|
                FileUtils.remove_dir folder, true
              end
            else
              @collection.Collection.create(file_name: zip)
            end
    respond_to do |format|
      if @collection.save
        format.html { redirect_to @collection, notice: 'Collection was successfully created.' }
        format.json { render :show, status: :created, location: @collection }
      else
        format.html { render :new }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @collection.update(collection_params)
        format.html { redirect_to @collection, notice: 'Collection was successfully updated.' }
        format.json { render :show, status: :ok, location: @collection }
      else
        format.html { render :edit }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @collection.destroy
    respond_to do |format|
      format.html { redirect_to collections_url, notice: 'Collection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_collection
      @collection = Collection.find(params[:id])
    end

    def collection_params
      params.require(:collection).permit(
        :image
      )
    end
end
