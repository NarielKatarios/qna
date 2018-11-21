class Answer < ApplicationRecord
  validates :body, presence: true
  validates :question_id, presence: true
  validates :user_id, presence: true
  belongs_to :question, foreign_key: 'question_id'
  belongs_to :user, foreign_key: 'user_id'
  has_many :attachments, as: :attachable
  has_many :votes, as: :votable, dependent: :destroy
  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true
end
