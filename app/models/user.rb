class User < ActiveRecord::Base
  attr_accessible :name
  # Alias for <tt>acts_as_taggable_on :tags</tt>:
  acts_as_taggable
  acts_as_taggable_on :skills, :interests
end
