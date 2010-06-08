class Token < ActiveRecord::Base
  before_validation :generate_keys
  
  def generate_keys
    self.token ||= ActiveSupport::SecureRandom.hex(10)
    self.secret ||= ActiveSupport::SecureRandom.hex(20)
  end
end
