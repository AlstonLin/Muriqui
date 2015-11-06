class Test < ActiveRecord::Base
  belongs_to :problem
  belongs_to :owner
end
