class Account < ActiveRecord::Base
  belongs_to :user, class_name: 'Person'
  validates :email, :password, presence: true
  has_secure_password

  def self.authenticate(email, password)
    user = self.where(email: email).first
    user.authenticate(password)
  end

  def Account.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
