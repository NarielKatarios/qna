require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let!(:question) { create(:question) }
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new answer in the database' do
        expect{post :create, params: { question_id: question, answer: attributes_for(:answer) }}.to change(question.answers.reload, :count).by(1)
      end
      it 'redirects to show view' do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }
        expect(response).to redirect_to question_path(assigns[:question])
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new answer in the database' do
        expect{post :create, params: { question_id: question, answer: attributes_for(:invalid_answer) }}.to_not change(question.answers.reload, :count)
      end
      it 're-renders new view' do
        post :create, params: { question_id: question, answer: attributes_for(:invalid_answer) }
        expect(response).to render_template 'questions/show'
      end
    end
  end
end
