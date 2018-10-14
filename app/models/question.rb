class Question < ApplicationRecord
  validates :title, :body, :user_id, presence: true

  has_many :answers
  has_many :attachments, as: :attachable
  belongs_to :user, foreign_key: 'user_id'

  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true
end
