class Assessment < ActiveRecord::Base

  validates :user_id, :name, :key, { presence: true }

end
