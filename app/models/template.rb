class Template < ActiveRecord::Base
  # Relationships
  belongs_to :creator, :class_name => 'User', :foreign_key => 'creator_id'
  belongs_to :remover, :class_name => 'User', :foreign_key => 'remover_id'
  # Validation
  validates :code, presence: true
  validates :mode, presence: true
  validates :name, presence: true
  validates :creator, presence: true
  # Modes
  MODES = ['text/x-csrc', 'text/x-c++src', 'text/x-python']
end
