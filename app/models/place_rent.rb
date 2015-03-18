class PlaceRent < ActiveRecord::Base
  belongs_to :parking
  belongs_to :car
  validates :starts_at, :ends_at, :parking, :car, presence: true
  before_create :calculate_price

  def total_time
    (ends_at - starts_at) / 1.day
  end

  def calculate_price
    days = total_time.floor
    hours = ((total_time - days) * 24).ceil
    self.price = (parking.day_price * days + parking.hour_price * hours).to_f
  end

  def abandon
    self.ends_at = Time.now
    self.save
  end
end
