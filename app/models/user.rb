require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt
  # Remember to create a migration!

  validates :username, :email, :hashed_password, { presence: true }
  validates :email, { uniqueness: true }
  validates :email, format: { with: /^[a-zA-Z0-9]+.?[a-zA-Z0-9]*@[a-zA-Z0-9]*.?[a-zA-Z0-9]*.[a-zA-Z]{2,}.?[a-zA-Z]{2,}/, multiline: true }

  def password
    @password ||= Password.new(hashed_password)
  end

  def password=(new_password)
    self.hashed_password = Password.create(new_password)
  end

  def self.authenticate( email, password)

    user = User.find_by(email: email.strip)
    if user && (user.password == password)
      return user
    end
      return nil
  end

end
