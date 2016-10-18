class Assessment < ActiveRecord::Base

  belongs_to :user

  validates :user_id, :name, :key, { presence: true }

end
