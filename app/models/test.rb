class Test < ActiveRecord::Base
  belongs_to :source_code
  belongs_to :owner, class_name: "User"
  belongs_to :test_case
  validates :owner, presence: true
  validates :source_code, presence: true
  validates :test_case, presence: true
end
