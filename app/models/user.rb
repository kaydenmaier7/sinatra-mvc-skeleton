require 'bcrypt'

class User < ActiveRecord::Base
  # users.password_hash in the database is a :string
  include BCrypt

	validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :password
  validates_presence_of :email
  validates_uniqueness_of :email

  def password
    @password ||= Password.new(hashed_password) #May need to update depending on migration string name
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.hashed_password = @password #May need to update depending on migration string name
  end

end
