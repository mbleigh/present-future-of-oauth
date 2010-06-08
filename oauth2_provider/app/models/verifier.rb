class Verifier < ActiveRecord::Base
  validates_presence_of :client, :user, :code
  
  belongs_to :client
  belongs_to :user
  
  def self.generate(client, user, redirect)
    Verifier.create(
      :client => client, 
      :user => user,
      :code => ActiveSupport::SecureRandom.hex(5),
      :expires_at => 5.minutes.from_now,
      :redirect_uri => redirect
    )
  end
end
