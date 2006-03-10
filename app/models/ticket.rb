class Ticket < ActiveRecord::Base
  has_one :state
  has_one :client
  has_one :user
end
