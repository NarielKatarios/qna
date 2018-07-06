class Question < ApplicationRecord
  validates :title, :body, presence: true
  validates :user_id, presence: true

  has_many :answers
  belongs_to :user, foreign_key: 'user_id'
end
