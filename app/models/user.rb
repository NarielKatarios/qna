class User < ApplicationRecord
  validates :nickname, presence: true
  has_many :answers
  has_many :questions
end
