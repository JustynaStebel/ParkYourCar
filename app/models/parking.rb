class Parking < ActiveRecord::Base
  has_many :place_rents
  belongs_to :address, dependent: :destroy
  belongs_to :owner
  validates :places, :hour_price, :day_price, presence: true
  KINDS = ["outdoor", "indoor", "private", "street"]
  validates :kind, inclusion: { in: KINDS }
  validates :hour_price, :day_price, numericality: true
  accepts_nested_attributes_for :address
  before_destroy :finish_rent

  def finish_rent
    place_rents.each(&:abandon)
  end

  scope :is_public, -> { where.not(kind: 'private') }
  scope :is_private, -> { where(kind: 'private') }
  scope :day_price_range, -> (day_price_min, day_price_max) { where(day_price: day_price_min..day_price_max) }
  scope :hour_price_range, -> (hour_price_min, hour_price_max) { where(hour_price: hour_price_min..hour_price_max) }
  scope :given_city_parkings, -> (city) { joins(:address).merge(Address.where(city: city)) }

  def self.search(options={})
    parkings = Parking.all
    parkings = parkings.is_public if options[:public_parking].present?
    parkings = parkings.is_private if options[:private_parking].present?
    parkings = parkings.day_price_range(options[:day_price_min], options[:day_price_max]) if options[:day_price_min].present? && options[:day_price_max].present?
    parkings = parkings.hour_price_range(options[:hour_price_min], options[:hour_price_max]) if options[:hour_price_min].present? && options[:hour_price_max].present?
    parkings = parkings.given_city_parkings(options[:city]) if options[:city].present?
    parkings
  end
end
