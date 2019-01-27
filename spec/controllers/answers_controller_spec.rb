require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let!(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:question) { create(:question, user_id: user.id) }
  let(:answer) { create(:answer, question_id: question.id, user_id: user.id) }
  let(:answer2) { create(:answer, question_id: question.id, user_id: user2.id) }

  describe 'POST #create', remote: true do
    context 'with valid attributes', js: true do
      sign_in_user
      it 'saves the new answer in the database' do

        expect{post :create, params: { user_id: user.id, question_id: question.id, answer: attributes_for(:answer), format: :js }}.to change(question.answers, :count).by(1), format: :js
      end
      it 'renders to question show view' do
        byebug
        # post :create, question_id: question, answer: attributes_for(:answer), format: :js
        post :create, params: { user_id: user.id, question_id: question, answer: attributes_for(:answer) }, format: :js
        expect(JSON.parse(response.body)['id']).to eq question.answers.last.id
        # expect(response).to eq question.answers.last.id
      end
    end

    context 'with invalid attributes', js: true do
      sign_in_user
      it 'does not save the new answer in the database' do
        post :create, params: { user_id: user, question_id: question, answer: attributes_for(:invalid_answer), format: :js }, format: :js
        expect(response).to_not change(question.answers.reload, :count)
      end
      it 're-renders new view' do
        post :create, params: { user_id: user.id, question_id: question.id, answer: attributes_for(:invalid_answer), format: :js }, format: :js
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  let(:answer) { create(:answer, question_id: question.id, user_id: subject.current_user.id) }
  before { sign_in(user) }

  describe 'DELETE #destroy' do
    sign_in_user
    before { answer }
    it 'deletes answer' do
      expect { delete :destroy, params: { question_id: question.id, id: answer.id } }.to change(Answer, :count).by(-1)
    end

    it 'redirects to index view' do
      delete :destroy, params: { question_id: question.id, id: answer.id }
      expect(response).to redirect_to questions_path
    end
  end

  describe 'PATH #update' do

    sign_in_user
    before { question }
    it 'assigns the requested answer to @answer' do
      patch :update, params: { user_id: user, id: answer, question_id: question, answer: attributes_for(:answer) }, format: :js
      expect(assigns(:answer)).to eq answer
    end

    it 'assigns the request question' do
      patch :update, params: { user_id: user, id: answer, question_id: question, answer: attributes_for(:answer) }, format: :js
      expect(assigns(:question)).to eq question
    end

    it 'changes answer attributes' do
      patch :update, params: { user_id: user, id: answer, question_id: question, answer: {body: 'new body'} }, format: :js
      answer.reload
      expect(answer.body).to eq 'new body'
    end

    it 'render update template' do
      patch :update, params: { user_id: user, id: answer, question_id: question, answer: attributes_for(:answer) }, format: :js
      expect(response).to render_template :update
    end
  end


  describe 'post #like' do
    sign_in_user
    it 'likes the answer' do
      post :like, params: { question_id: question.id, answer_id: answer2.id }, format: :js
      expect(answer2.votes.find_by( user_id: @user.id ).like ).to be(true)
    end
  end

  describe 'post #dislike' do
    sign_in_user
    it 'dislikes the answer' do
      post :dislike, params: { question_id: question.id, answer_id: answer2.id }, format: :js
      expect(answer2.votes.find_by( user_id: @user.id ).dislike ).to be(true)
    end
  end
end
