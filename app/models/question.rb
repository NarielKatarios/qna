class Question < ApplicationRecord
  validates :title, :body, :user_id, presence: true

  has_many :answers
  has_many :attachments
  belongs_to :user, foreign_key: 'user_id'

  accepts_nested_attributes_for :attachments
end
