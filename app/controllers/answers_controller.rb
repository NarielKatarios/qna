class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :current_user, only: [:destroy]


  #def index
  #  @answers = @question.answers.all
  #end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params.merge(user_id: current_user.id))
    #@answer.attachments.build

    @answers = @question.answers.all
    if @answer.save
      redirect_to question_path(@question)
    else

      #flash.now[:notice] = 'Need text'
      #flash[:notice] = 'Need text'
      flash.now[:error] = "Need text"
      render 'questions/show'
    end
  end

  def update
    @answer = Answer.find(params[:id])
    @answer.update(answer_params)
    @question = @answer.question
    answers = @question.answers
    best = answers.select {|answer| answer.id == @question.best_answer}
    @answers = best + (answers - best).sort
    @answers = @question.answers
  end

  def destroy
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find_by(user_id: current_user.id, id: params[:id])

    if @answer.present?
      @answer.destroy
      flash[:notice] = 'Your answer has been successfully deleted.'
      redirect_to questions_path
    else
      render 'questions/show'
    end
  end

  private

  def answer_params
    params.require(:answer ).permit(:body, attachments_attributes: [:id, :file, :_destroy] )
  end
end