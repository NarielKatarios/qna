class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :current_user, only: [:destroy]
  before_action :load_comment, only: [:update, :destroy]
  before_action :load_poly_model, only: [:create, :update, :destroy]

  respond_to :js

  def create
    respond_with(@comment = @polymorphic_model.comments.create(comment_params.merge(user_id: current_user.id)))
  end

  def update
    @comment.update(comment_params)
    @question = @comment.question
    @comments = @polymorphic_model.answers
    respond_with @comment
  end

  def destroy
    respond_with(@comment = @polymorphic_model.comments.find_by(user_id: current_user.id, id: params[:id]).destroy)
  end

  private

  def load_poly_model
    @polymorphic_model = if params[:answer_id]
      Answer.find(params[:answer_id])
    else
      Question.find(params[:question_id])
    end
  end

  def load_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end