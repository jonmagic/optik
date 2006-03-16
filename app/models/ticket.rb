class Ticket < ActiveRecord::Base
  validates_presence_of [ :description, :user_id, :state_id ]
  acts_as_taggable
  belongs_to :user
  belongs_to :state
  has_many :notes
  
  def self.search(query)
    if !query.to_s.strip.empty?
      tokens = query.split.collect {|c| "%#{c.downcase}%"}
      find_by_sql(["SELECT * from tickets WHERE #{ (["(LOWER(description) LIKE ?)"] * tokens.size).join(" AND ") }", *tokens.collect { |token| [token] * 1 }.flatten])
    else
      []
    end
  end
  
end
