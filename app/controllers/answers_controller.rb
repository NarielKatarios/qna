class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :current_user, only: [:destroy]
  before_action :load_answer, only: [:like, :dislike]

  include Voted
  include Commented

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params.merge(user_id: current_user.id))
    @answers = @question.answers.all

    respond_to do |format|
      if @answer.save
        format.js do
          PrivatePub.publish_to "/questions/#{@question.id}/answers", answer: @answer.to_json
          render nothing: true
        end
        #format.html { render partial: 'questions/answers', layout: false }
        #format.js { render json: @answer }
      else
        format.js do
          PrivatePub.publish_to "/questions/#{@question.id}/answers", errors: @answer.errors.full_messages
          render nothing: true
        end
        #format.html {render text: @answer.errors.full_messages.join("\n"), status: :unprocessable_entity }
        #format.js {render json: @answer.errors.full_messages, status: :unprocessable_entity }
      end
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

  def vote_model
    @answer
  end

  def load_answer
    @answer = Answer.find(params[:answer_id])
  end

  def answer_params
    params.require(:answer ).permit(:body, attachments_attributes: [:id, :file, :_destroy] )
  end
end