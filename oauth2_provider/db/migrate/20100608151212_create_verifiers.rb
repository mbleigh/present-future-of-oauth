class CreateVerifiers < ActiveRecord::Migration
  def self.up
    create_table :verifiers do |t|
      t.belongs_to :client
      t.belongs_to :user
      t.string :code
      t.datetime :expires_at
      t.string :redirect_uri
      t.string :scope
      
      t.timestamps
    end
  end

  def self.down
    drop_table :verifiers
  end
end
