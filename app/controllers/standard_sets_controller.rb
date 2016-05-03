class StandardSetsController < ApplicationController
  include UuidReaders

  def index
    @standard_sets = StandardSet.latest_first.page(params[:page])
  end

  def show
    @standard_set = StandardSet.where(uuid:uuid_from_parameters).first!
    @standards = @standard_set.standards.page(params[:page])
    @subtitle = l(@standard_set.created_at, format: :long)
  end

  def new
    @standard_set = StandardSet.new
    @standard_types = StandardType.alphabetical.pluck(:id,:name)
  end

  def create
    @standard_set = StandardSet.new(standard_set_params)
    if @standard_set.save
      redirect_to standard_set_path(@standard_set.friendly_uuid)
    else
      render :new
    end
  end

  private

  def standard_set_params
    params.required(:standard_set).permit(:standard_count,:standard_type_id)
  end
end