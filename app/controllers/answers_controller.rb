class AnswersController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]
  before_action :current_user, only: [:destroy]
  before_action :load_answer, only: %i[update destroy]

  respond_to :js
  respond_to :json, only: [:create]

  include Voted

  def create
    @question = Question.find(params[:question_id])
    @answers = @question.answers.all
    @answer = @question.answers.create(answer_params.merge(user_id: current_user.id))
    @comments = @answer.comments
    respond_with(@answer)
  end

  def update
    authorize @answer
    @answer.update(answer_params)
    answers = @question.answers
    best = answers.select { |answer| answer.id == @question.best_answer }
    @answers = best + (answers - best).sort
    @answers = @question.answers
    respond_with @answer
  end

  def destroy
    @answers = @question.answers
    respond_with(@answer = @answers.find_by(id: params[:id]).destroy)
  end

  private

  def load_answer
    @answer = Answer.find(params[:id])
    @question = @answer.question
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: %i[id file _destroy])
  end
end
