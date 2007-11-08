class Ticket < ActiveRecord::Base
  acts_as_taggable
  belongs_to :user
  belongs_to :state
  has_many :notes

  def self.quicksearch(query, options = {})
    if !query.to_s.strip.empty?
      tokens = query.split
      resultshash = {}
      tokens.each do |token|
        Ticket.find_by_sql(["SELECT tickets.* FROM tickets WHERE LOWER(tickets.description) LIKE ?", '%'+token.downcase+'%']).each do |result|
          resultshash[result.id] ||= [0, nil]
          resultshash[result.id][0] += 1
          resultshash[result.id][1] = result
        end
        Note.find_by_sql(["SELECT notes.* FROM notes WHERE notes.content LIKE ?", '%'+token.downcase+'%']).each do |result|
          resultshash[result.ticket_id] ||= [0, nil]
          resultshash[result.ticket_id][0] += 1
          resultshash[result.ticket_id][1] ||= Ticket.find(result.ticket_id)
        end
      end
      Ticket.find_tagged_with(options.merge(:any => tokens)).each do |result|
        resultshash[result.id] ||= [0, nil]
        resultshash[result.id][0] += 1
        resultshash[result.id][1] = result
      end
      results = resultshash.keys.collect {|k| resultshash[k][1]}.sort {|b,a| resultshash[a.id][0] <=> resultshash[b.id][0] || a.updated_at <=> b.updated_at}
        offset = options.delete(:offset) || 0
        limit = options.delete(:limit) || 100000
      return options.delete(:count) ? resultshash.keys.length : results[offset..(offset+limit)]
    else
      []
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
