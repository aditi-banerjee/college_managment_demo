class UploadFeeStructuresController < ApplicationController
  before_action :authenticate_user!
  before_action(
    :set_upload_fee_structure,
    only: [
      :destroy
    ]
  )

  def index
    @upload_fee_structures = UploadFeeStructure.all
  end

  def new
    @upload_fee_structure = UploadFeeStructure.new
  end

  def create
    @upload_fee_structure = UploadFeeStructure.new(upload_fee_structure_params)

    respond_to do |format|
      if @upload_fee_structure.save
        UploadFeeStructureJob.set(wait: 0.seconds).perform_later(@upload_fee_structure)
        format.html { redirect_to upload_fee_structures_path, notice: 'Upload fee structure was successfully created.' }
        format.json { render :show, status: :created, location: @upload_fee_structure }
      else
        format.html { render :new }
        format.json { render json: @upload_fee_structure.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @upload_fee_structure.destroy
    respond_to do |format|
      format.html { redirect_to upload_fee_structures_url, notice: 'Upload fee structure was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_upload_fee_structure
      @upload_fee_structure = UploadFeeStructure.find(params[:id])
    end

    def upload_fee_structure_params
      params.require(
        :upload_fee_structure
      ).permit(
      :upload
      )
    end
end
