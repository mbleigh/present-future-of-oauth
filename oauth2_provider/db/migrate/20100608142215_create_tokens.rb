class CreateTokens < ActiveRecord::Migration
  def self.up
    create_table :tokens do |t|
      t.string :type
      t.string :token
      t.string :secret
      t.datetime :expires_at

      t.belongs_to :client
      t.belongs_to :user
      
      t.timestamps
    end
  end

  def self.down
    drop_table :tokens
  end
end
