class AddTicketTable < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.column :description, :string
      t.column :user_id, :integer
      t.column :client_id, :integer
      t.column :status_id, :integer
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end

  def self.down
    drop_table :posts    
  end
end
