require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  sign_in_user

  let(:question) { create :question }
  let(:answer) { create :answer }

  describe 'POST #create', remote: true do
    it 'loads question if poly_model is question' do
      post :create, params: { question_id: question.id, comment: attributes_for(:comment), format: :js }
      expect(assigns(:polymorphic_model)).to eq question
    end
    it 'loads answer if poly_model is answer' do
      post :create, params: { answer_id: answer.id, comment: attributes_for(:comment), format: :js }
      expect(assigns(:polymorphic_model)).to eq answer
    end
    it 'saves the new question\'s comment in the database' do
      expect { post :create, params: { question_id: question.id, comment: attributes_for(:comment), format: :js } }.to change(question.comments, :count).by(1), format: :js
    end
  end
end
