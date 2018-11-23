class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :current_user, only: [:destroy]
  before_action :load_comment, only: [:update, :destroy]

  include Commented

  def create
    @question = Question.find(params[:question_id])
    @comment = @question.comments.build(comment_params.merge(user_id: current_user.id))
    @comment.save

    #@answer = @question.answers.find(params[:answer_id])

  end

  def update
    @comment.update(comment_params)
    @question = @comment.question

    @comments = @question.answers
  end

  def destroy
    @question = Question.find(params[:question_id])
    @comment = @question.comments.find_by(user_id: current_user.id, id: params[:id])

    if @comment.present?
      @comment.destroy
      flash[:notice] = 'Your comment has been successfully deleted.'
      redirect_to questions_path
    else
      render 'questions/show'
    end
  end

  private

  def load_comment
    @comment = Comment.find(params[:comment_id])
    #@comment = Comment.find(params[:id])
  end



  def comment_params
    params.require(:comment).permit(:body)
  end
end