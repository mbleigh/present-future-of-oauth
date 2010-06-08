class AccessToken < Token
  before_create :generate_expires
  
  belongs_to :user
  belongs_to :client
  
  validates_presence_of :user, :client, :token, :secret
  
  def self.generate(client, user)
    create(:client => client, :user => user)
  end
  
  def generate_expires
    self.expires_at = 1.month.from_now
  end
  
  def to_response_hash
    {
      'access_token' => self.token,
      'expires_in' => (self.expires_at - Time.now).to_i
    }
  end
  
  def to_form
    to_response_hash.map{|a| a.map{|i| CGI.escape(i.to_s)}.join('=')}.join('&')
  end
end