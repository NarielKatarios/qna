class Comment < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :commentable, polymorphic: true

  validates :user_id, :body, presence: true
end
