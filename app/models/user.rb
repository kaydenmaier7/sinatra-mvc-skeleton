require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt
  # Remember to create a migration!
  has_many :votes, class_name: 'Vote', foreign_key: 'voter_id'
  has_many :comments, class_name: 'Comment', foreign_key: 'commenter_id'
  has_many :questions, class_name: 'Question', foreign_key: 'author_id'
  has_many :answers, class_name: 'Answer', foreign_key: 'answerer_id'

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
