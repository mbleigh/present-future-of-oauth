class Client < ActiveRecord::Base
  before_validation :generate_keys
  
  belongs_to :user

  validates_presence_of :key, :secret, :user
  
  def generate_keys
    self.key ||= ActiveSupport::SecureRandom.hex(10)
    self.secret ||= ActiveSupport::SecureRandom.hex(20)
  end
end
