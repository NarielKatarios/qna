class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :load_question, only: [:show, :edit, :update, :destroy]
  before_action :load_question_for_voted, only: [:like, :dislike]

  include Voted

  def index
    @questions = Question.all
  end

  def show
    @answer = @question.answers.build
    @answer.attachments.build
    answers = @question.answers
    best = answers.select {|answer| answer.id == @question.best_answer}
    @answers = best + (answers - best)
    response.headers["Cache-Control"] = "no-cache, no-store"
  end

  def new
    @question = Question.new
    @question.attachments.build
  end

  def edit
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      flash[ :notice] = 'Your question has been successfully created.'
      redirect_to question_path(@question)
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def destroy
    if @question.destroy
      flash[:notice] = 'Your question has been deleted.'
      redirect_to questions_path
    else
      render :edit
    end
  end

  def best_answer
    @question = Question.find(params[:question_id])
    @question.update(best_answer: params[:answer_id])
    @question.reload
    redirect_to question_path(@question)
  end

  # def like
  #   @question = Question.find(params[:question_id])
  #   vote = @question.votes.find_by(user_id: current_user.id)
  #   if vote
  #     vote.update(like: !vote.like, dislike: false)
  #   else
  #     @question.votes.create(user: current_user, like: true, dislike: false)
  #   end
  #   response.headers["Cache-Control"] = "no-cache, no-store"
  # end
  #
  # def dislike
  #   @question = Question.find(params[:question_id])
  #   vote = @question.votes.find_by(user_id: current_user.id)
  #   if vote
  #     vote.update(like: false, dislike: !vote.dislike)
  #   else
  #     @question.votes.create(user: current_user, like: false, dislike: true)
  #   end
  #   response.headers["Cache-Control"] = "no-cache, no-store"
  # end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def load_question_for_voted
    @question = Question.find(params[:question_id])
  end

  def vote_model
    @question
  end

  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:id, :file, :_destroy] )
  end
end
