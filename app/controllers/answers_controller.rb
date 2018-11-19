class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :current_user, only: [:destroy]

  def create
    @question = Question.find(params[:question_id])
    #@answer = @question.answers.new(answer_params.merge(user_id: current_user.id))
    @answer = @question.answers.build(answer_params.merge(user_id: current_user.id))
    @answers = @question.answers.all

    respond_to do |format|
      if @answer.save
        format.html { render partial: 'questions/answers', layout: false }
        format.js { render json: @answer }
      else
        format.html {render text: @answer.errors.full_messages.join("\n"), status: :unprocessable_entity }
        format.js {render json: @answer.errors.full_messages, status: :unprocessable_entity }
      end
    end

    # if @answer.save
    #   redirect_to question_path(@question)
    # else
    #   flash.now[:notice] = 'Need text'
    #   render 'questions/show'
    # end
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

  def like
    @answer = Answer.find(params[:answer_id])
    vote = @answer.votes.find_by(user_id: current_user.id)
    if vote
      vote.update(like: !vote.like, dislike: false)
    else
      @answer.votes.create(user: current_user, like: true, dislike: false)
    end
  end

  def dislike
    @answer = Answer.find(params[:answer_id])
    vote = @answer.votes.find_by(user_id: current_user.id)
    if vote
      vote.update(like: false, dislike: !vote.dislike)
    else
      @answer.votes.create(user: current_user, like: false, dislike: true)
    end  end

  private

  def answer_params
    params.require(:answer ).permit(:body, attachments_attributes: [:id, :file, :_destroy] )
  end
end