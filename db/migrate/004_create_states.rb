class CreateStates < ActiveRecord::Migration
  def self.up
    create_table :states do |t|
      # t.column :name, :string
    end
  end

  def self.down
    drop_table :states
  end
end
