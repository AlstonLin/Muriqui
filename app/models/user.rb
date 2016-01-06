class User < ActiveRecord::Base
  # Relationships
  has_and_belongs_to_many :flags, :class_name => 'TestCase'
  has_many :courses_created, :class_name => 'Course', :foreign_key => 'creator_id'
  has_many :courses_removed, :class_name => 'Course', :foreign_key => 'remover_id'
  has_many :assignments_created, :class_name => 'Assignment', :foreign_key => 'creator_id'
  has_many :assignments_removed, :class_name => 'Assignment', :foreign_key => 'remover_id'
  has_many :problems_created, :class_name => 'Problem', :foreign_key => 'creator_id'
  has_many :problems_removed, :class_name => 'Problem', :foreign_key => 'remover_id'
  has_many :test_cases_created, :class_name => 'TestCase', :foreign_key => 'creator_id'
  has_many :test_cases_removed, :class_name => 'TestCase', :foreign_key => 'remover_id'
  # Validation
  validates :name, presence: true
  validates :email, presence: true
  # Auth
  devise :omniauthable, :database_authenticatable, :confirmable, \
   :registerable, :recoverable, :rememberable, :trackable, :validatable

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      user.skip_confirmation! 
    end
  end
  # Other Methods
  def get_tests_created_today
    self.test_cases_created.where("created_at >= ?", Time.zone.now.beginning_of_day).count
  end
end
