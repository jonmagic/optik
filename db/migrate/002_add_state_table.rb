class AddStateTable < ActiveRecord::Migration
  def self.up
    create_table :states do |t|
      t.column :description, :string
      t.column :priority, :integer
    end
    remove_column :tickets, :status_id    
    add_column :tickets, :state_id, :integer    
  end

  def self.down
    drop_table :states    
    remove_column :tickets, :state_id    
    add_column :tickets, :status_id, :integer
  end
  
end
