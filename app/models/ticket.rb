class Ticket < ActiveRecord::Base
  acts_as_taggable
  belongs_to :user
  belongs_to :state
  has_many :notes

  def self.fullsearch(query, options = {})
    if !query.to_s.strip.empty?
      tokens = query.split
      resultshash = {}
      Ticket.find_by_sql(["SELECT tickets.* FROM tickets WHERE 0" + (" OR LOWER(tickets.description) LIKE ?") * tokens.length] + tokens.map {|t| '%'+t.downcase+'%'}).each do |result|
        resultshash[result.id] ||= [0, nil]
        resultshash[result.id][0] += 1
        x = (Time.now - result.created_at)/86400
        y = ((-(x**2)/200)+8.49999).to_i # Makes a bump up to 8 points on a reverse-exponential scale, from 0 to 50 days old.
        resultshash[result.id][0] += y if y > 0
        resultshash[result.id][1] = result
      end
      Note.find_by_sql(["SELECT notes.* FROM notes WHERE 0" + (" OR LOWER(notes.content) LIKE ?") * tokens.length] + tokens.map {|t| '%'+t.downcase+'%'}).each do |result|
        resultshash[result.ticket_id] ||= [0, nil]
        resultshash[result.ticket_id][0] += 1
        resultshash[result.ticket_id][1] ||= Ticket.find(result.ticket_id)
      end
      Ticket.find_tagged_with(options.merge(:any => tokens)).each do |result|
        resultshash[result.id] ||= [0, nil]
        resultshash[result.id][0] += 1
        resultshash[result.id][1] = result
      end
      results = resultshash.keys.collect {|k| resultshash[k][1]}.sort {|b,a| resultshash[a.id][0] <=> resultshash[b.id][0] || b.updated_at <=> a.updated_at}
        offset = options.delete(:offset) || 0
        limit = options.delete(:limit) || 100000
      return results[offset..(offset+limit)]
    else
      []
    end
  end

  def self.similar_search(query, options = {})
    if !query.to_s.strip.empty?
      tokens = query.split
      resultshash = {}
      offset = options.delete(:offset) || 0
      limit = options.delete(:limit) || 100000
      Ticket.find_tagged_with(options.merge(:any => tokens)).each do |result|
        resultshash[result.id] ||= [0, nil]
        resultshash[result.id][0] += 1
        resultshash[result.id][1] = result
      end
      results = resultshash.keys.collect {|k| resultshash[k][1]}.sort {|a,b| b.updated_at <=> a.updated_at}
      return results[offset..(offset+limit)]
    else
      []
    end
  end
end
