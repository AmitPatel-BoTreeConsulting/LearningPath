class LearnTime < ActiveRecord::Base

  belongs_to :user
  belongs_to :link, counter_cache: true
  
end
