class Note < ActiveRecord::Base
  belongs_to :ticket, :dependent => true
  belongs_to :user
end
