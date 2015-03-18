class Person < ActiveRecord::Base
  has_many :cars, foreign_key: 'owner_id'
  has_many :parkings
  validates :first_name, presence: true
  has_one :account, foreign_key: 'user_id'

  def full_name
    "#{first_name} #{last_name}".strip
  end
end
