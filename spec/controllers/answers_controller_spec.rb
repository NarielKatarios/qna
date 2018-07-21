require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let!(:user) { create(:user) }
  let!(:question) { create(:question, user_id: user.id) }
  let(:answer) { create(:answer, question_id: question.id, user_id: user.id) }

  describe 'POST #create' do
    context 'with valid attributes' do
      sign_in_user
      it 'saves the new answer in the database' do
        expect{post :create, params: { user_id: user.id, question_id: question.id, answer: attributes_for(:answer), format: :js }}.to change(question.answers.reload, :count).by(1)
      end
      it 'redirects to question show view' do
        post :create, params: { user_id: user.id, question_id: question, answer: attributes_for(:answer), format: :js }
        expect(response).to redirect_to question_path(assigns[:question])
      end
    end

    context 'with invalid attributes' do
      sign_in_user
      it 'does not save the new answer in the database' do
        expect{post :create, params: { user_id: user, question_id: question, answer: attributes_for(:invalid_answer), format: :js }}.to_not change(question.answers.reload, :count)
      end
      it 're-renders new view' do
        post :create, params: { user_id: user.id, question_id: question.id, answer: attributes_for(:invalid_answer), format: :js }
        expect(response).to render_template 'questions/show'
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
end
