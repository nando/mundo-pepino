class Session < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id
  attr_protected :user_id

  attr_accessor :name, :password

  def before_validation
    self.user = User.find_by_name_and_password(name, password)
  end
end
