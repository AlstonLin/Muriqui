class User < ActiveRecord::Base
  has_many :tests
  has_many :courses_created, class_name: "Course"
  has_many :assignments_created, class_name: "Assignment"
  has_many :test_cases_created, class_name: "TestCase"
  has_many :source_codes
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