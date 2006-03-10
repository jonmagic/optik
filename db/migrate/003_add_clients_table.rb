class AddClientsTable < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.column :nickname, :string
      t.column :firstname, :string
      t.column :lastname, :string
      t.column :email, :string
      t.column :homephone, :string
      t.column :workphone, :string
      t.column :cellphone, :string
      t.column :fax, :string      
      t.column :address1, :string
      t.column :address2, :string
      t.column :city, :string
      t.column :state, :string
      t.column :zip, :string      
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end

  def self.down
    drop_table :clients    
  end
end
