require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  sign_in_user

  let!(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let(:question) { create :question }
  let(:answer) { create :answer }

  describe 'POST #create', remote: true do

    it 'loads question if poly_model is question' do
      post :create, params: { user_id: user.id, question_id: question.id, comment: attributes_for(:comment), format: :js }
      expect(assigns(:poly_model)).to eq question
    end
    it 'loads answer if poly_model is answer' do
      post :create, params: { user_id: user.id, answer_id: answer.id, comment: attributes_for(:comment), format: :js }
      expect(assigns(:poly_model)).to eq answer
    end
    it 'saves the new question\'s comment in the database' do
      post :create, params: { user_id: user.id, question_id: question.id, comment: attributes_for(:comment), format: :js }
      expect(response).to change(question.comments, :count).by(1)
    end
  end
end
