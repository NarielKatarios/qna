require 'active_support/concern'

module Commented
  extend ActiveSupport::Concern

  included do
    # before_action :load_poly_model, only: [:create, :update, :destroy]
  end

  # def create
  #   @comment = polymorphic_model.comments.build(comment_params.merge(user_id: current_user.id))
  #   @comment.save
  #   render nothing: true
  # end
  #
  # def update
  #   @comment.update(comment_params)
  #   @question = @comment.question #????
  #
  #   @comments = polymorphic_model.answers #????
  # end
  #
  # def destroy
  #   @comment = polymorphic_model.comments.find_by(user_id: current_user.id, id: params[:id])
  #
  #   if @comment.present?
  #     @comment.destroy
  #     flash[:notice] = 'Your comment has been successfully deleted.'
  #     redirect_to questions_path
  #   else
  #     render 'questions/show'
  #   end
  # end
end