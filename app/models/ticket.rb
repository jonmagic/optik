class Ticket < ActiveRecord::Base
  acts_as_taggable
  has_one :state
  has_one :user
end
