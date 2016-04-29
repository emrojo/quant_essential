class AssaySetsController < ApplicationController
  include UuidReaders

  def index
    @assay_sets = AssaySet.latest_first
  end

  def new
    @assay_set = AssaySet.new
  end

  def create
    @assay_set = AssaySet.new(assay_set_params)
    if @assay_set.save
      redirect_to assay_set_path(@assay_set.friendly_uuid)
    else
      render :new
    end
  end

  def show
    @assay_set = AssaySet.where(uuid:uuid_from_parameters).first!
  end

  private

  def assay_set_params
    params.required(:assay_set).permit(:assay_count)
  end
end