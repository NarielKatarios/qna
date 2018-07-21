class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params.merge(user_id: current_user.id))
    if @answer.save
      redirect_to question_path(@question)
    else
      flash[:notice] = 'Need text'
      render 'questions/show'
    end
  end

  def destroy
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find_by(user_id: current_user.id, id: params[:id])

    if @answer.destroy
      flash[:notice] = 'Your answer has been successfully deleted.'
      redirect_to questions_path
    else
      render 'questions/show'
    end
  end

  private

  def answer_params
    params.require(:answer ).permit(:body)
  end
end