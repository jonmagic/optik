require 'taggable'
ActiveRecord::Base.send(:include, ActiveRecord::Acts::Taggable)

require File.dirname(__FILE__) + '/lib/taggable'