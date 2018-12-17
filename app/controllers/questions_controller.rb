class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :load_question, only: [:show, :edit, :update, :destroy]

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
    @comment = @question.comments.build
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
      PrivatePub.publish_to "/questions/new", question: @question.to_json
      redirect_to question_path(@question)
      flash[:notice] = 'Your question has been successfully created.'
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

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:id, :file, :_destroy] )
  end
end
