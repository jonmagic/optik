class Ticket < ActiveRecord::Base
  acts_as_taggable
  belongs_to :user
  belongs_to :state
  has_many :notes

  def self.quicksearch(query, options = {})
    conds = Caboose::EZ::Condition.new
    for item in query.split
      item_cond = Caboose::EZ::Condition.new :tickets do
        any_of(:description, :id).nocase =~ "%#{item}%"
        condition :notes, {:outer => :or} do any_of(:content).nocase =~ "%#{item}%" end
        condition :tags, {:outer => :or} do any_of(:name).nocase =~ "%#{item}%" end
      end
      conds << item_cond
    end
    options[:conditions] = conds.to_sql
    options[:include] = [:notes, :tags]
    if options.delete(:count)
      return self.count(options)
    else
      return self.find(:all, options)
    end
  end


#   def self.search(query)
#     if !query.to_s.strip.empty?
#       tokens = query.split.collect {|c| "%#{c.downcase}%"}
#       find_by_sql(["SELECT * from tickets WHERE #{ (["(LOWER(description) LIKE ?)"] * tokens.size).join(" AND ") }", *tokens.collect { |token| [token] * 1 }.flatten])
#     else
#       []
#     end
#   end

  
end
