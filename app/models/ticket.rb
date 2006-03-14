class Ticket < ActiveRecord::Base
  acts_as_taggable
  belongs_to :user
  belongs_to :state
  
end
