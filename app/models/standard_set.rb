class StandardSet < ActiveRecord::Base
  include ActiveUUID::UUID
  include HasUuid
  include OrderScopes

  def to_param; friendly_uuid; end

  attr_accessor :standard_count

  has_many :standards, inverse_of: :standard_set, validate: true
  belongs_to :standard_type

  validates :standard_count, on: :create, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :standard_type, presence: true

  before_create :generate_standard_sets


  # Printables is an array of the items that get printed
  alias_attribute :printables, :standards


  private

  def generate_standard_sets
    standards.build([default_standard_attributes]*standard_count.to_i)
  end

  def default_standard_attributes
    {
      standard_type: standard_type
    }
  end

end
