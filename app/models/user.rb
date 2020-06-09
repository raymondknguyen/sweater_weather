class User < ApplicationRecord
  before_create :set_api_key

  validates :email, uniqueness: true, presence: true, case_sensitive: false
  validates :password_digest, confirmation: true

  has_secure_password

  private 

  def set_api_key
    self.api_key = generate_key
  end

  def generate_key
    loop do
      key = SecureRandom.hex(10)
      break key unless User.where(api_key: key).exists?
    end
  end
end
