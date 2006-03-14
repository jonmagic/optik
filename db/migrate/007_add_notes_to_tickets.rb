class AddNotesToTickets < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.column :content, :text
      t.column :ticket_id, :integer
      t.column :user_id, :integer
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
    remove_column :tickets, :client_id
  end

  def self.down
    drop_table :notes
  end
end
