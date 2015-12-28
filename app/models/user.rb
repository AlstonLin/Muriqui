class User < ActiveRecord::Base
  has_and_belongs_to_many :flags, :class_name => 'TestCase'

  has_many :courses_created, :class_name => 'Course', :foreign_key => 'creator_id'
  has_many :courses_removed, :class_name => 'Course', :foreign_key => 'remover_id'
  has_many :assignments_created, :class_name => 'Assignment', :foreign_key => 'creator_id'
  has_many :assignments_removed, :class_name => 'Assignment', :foreign_key => 'remover_id'
  has_many :problems_created, :class_name => 'Problem', :foreign_key => 'creator_id'
  has_many :problems_removed, :class_name => 'Problem', :foreign_key => 'remover_id'
  has_many :test_cases_created, :class_name => 'TestCase', :foreign_key => 'creator_id'
  has_many :test_cases_removed, :class_name => 'TestCase', :foreign_key => 'remover_id'


  def self.omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.image = auth.info.image
      user.token = auth.credentials.token
      user.expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end
