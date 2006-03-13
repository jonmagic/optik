class AddTagsToTickets < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.column :name, :string
    end
    create_table :tags_tickets do |t|
      t.column :ticket_id, :integer
      t.column :tag_id, :integer
    end
    remove_column :tags_tickets, :id
  end

  def self.down
    drop_table :tags
    drop_table :tags_tickets
  end
end
