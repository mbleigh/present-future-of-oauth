class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.belongs_to :user
      
      t.string :name
      t.string :key
      t.string :secret
      t.string :redirect_uri

      t.timestamps
    end
  end

  def self.down
    drop_table :clients
  end
end
