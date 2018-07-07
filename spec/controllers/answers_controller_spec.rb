require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let!(:user) { create(:user) }
  let!(:question) { create(:question, user_id: user.id) }
  let(:answer) { create(:answer, question_id: question.id, user_id: user.id) }

  describe 'POST #create' do
    context 'with valid attributes' do
      sign_in_user
      it 'saves the new answer in the database' do
        #expect{post :create, params: { user_id: user.id, question_id: question.id, answer: attributes_for(:answer) }}.to change(question.answers.reload, :count).by(1)
        expect(assigns(:answer).user_id).to eq subject.current_user.id
      end
      it 'redirects to show view' do
        post :create, params: { user_id: user.id, question_id: question, answer: attributes_for(:answer) }
        expect(response).to redirect_to question_path(assigns[:question])
      end
    end

    context 'with invalid attributes' do
      sign_in_user
      it 'does not save the new answer in the database' do
        expect{post :create, params: { user_id: user, question_id: question, answer: attributes_for(:invalid_answer) }}.to_not change(question.answers.reload, :count)
      end
      it 're-renders new view' do
        post :create, params: { user_id: user.id, question_id: question.id, answer: attributes_for(:invalid_answer) }
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
      expect(response).to redirect_to question_path(assigns[:question])
    end
  end
end
