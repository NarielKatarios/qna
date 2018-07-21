class Question < ApplicationRecord
  validates :title, :body, :user_id, presence: true

  has_many :answers
  belongs_to :user, foreign_key: 'user_id'
end
