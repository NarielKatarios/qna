require 'active_support/concern'

module Voted
  extend ActiveSupport::Concern

  def like
    vote = vote_model.votes.find_by(user_id: current_user.id)
    if vote
      vote.update(like: !vote.like, dislike: false)
    else
      vote_model.votes.create(user: current_user, like: true, dislike: false)
    end
    response.headers["Cache-Control"] = "no-cache, no-store"
  end

  def dislike
    vote = vote_model.votes.find_by(user_id: current_user.id)
    if vote
      vote.update(like: false, dislike: !vote.dislike)
    else
      vote_model.votes.create(user: current_user, like: false, dislike: true)
    end
    response.headers["Cache-Control"] = "no-cache, no-store"
  end
end