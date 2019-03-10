require 'active_support/concern'

module Voted
  extend ActiveSupport::Concern

  included do
    before_action :load_poly_model, only: %i[like dislike]
  end

  def like
    vote = polymorphic_model.votes.find_by(user_id: current_user.id)
    if vote
      vote.update(like: !vote.like, dislike: false)
    else
      polymorphic_model.votes.create(user: current_user, like: true, dislike: false)
    end
    response.headers['Cache-Control'] = 'no-cache, no-store'
  end

  def dislike
    vote = polymorphic_model.votes.find_by(user_id: current_user.id)
    if vote
      vote.update(like: false, dislike: !vote.dislike)
    else
      polymorphic_model.votes.create(user: current_user, like: false, dislike: true)
    end
    response.headers['Cache-Control'] = 'no-cache, no-store'
  end

  private

  def polymorphic_model
    params[:answer_id] ? @answer : @question
  end

  def load_poly_model
    if params[:answer_id]
      @answer = Answer.find(params[:answer_id])
    else
      @question = Question.find(params[:question_id])
    end
  end
end
