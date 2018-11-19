class Vote < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :votable, polymorphic: true
end
