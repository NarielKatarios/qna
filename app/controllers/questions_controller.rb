class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :load_question, only: [:show, :edit, :update, :destroy]
  before_action :build_answer, only: :show
  after_action :publish_question, only: :create


  respond_to :html

  include Voted

  def index
    respond_with(@questions = Question.all)
  end

  def show
    answers = @question.answers
    best = answers.select {|answer| answer.id == @question.best_answer}
    @answers = best + (answers - best)
    response.headers["Cache-Control"] = "no-cache, no-store"
    @comment = @question.comments.build
    respond_with @question
  end

  def new
    respond_with(@question = Question.new)
  end

  def edit
  end

  def create
    respond_with(@question = current_user.questions.create(question_params))
  end

  def update
    @question.update(question_params)
    respond_with @question
  end

  def destroy
    flash[:notice] = 'Your question has been deleted.' if @question.destroy
    respond_with(@question.destroy)
  end

  def best_answer
    @question = Question.find(params[:question_id])
    @question.update(best_answer: params[:answer_id])
    @question.reload
    redirect_to question_path(@question)
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def publish_question
    PrivatePub.publish_to "/questions/new", question: @question.to_json if @question.valid?
  end

  def build_answer
    @answer = @question.answers.build
  end

  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:id, :file, :_destroy] )
  end
end
