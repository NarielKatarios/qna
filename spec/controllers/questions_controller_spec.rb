require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question_id: question.id) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }

    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end
    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { user_id: user, id: question.id } }
    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'assigns new answer for question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    sign_in_user

    before { get :new }
    it 'assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    sign_in_user
    before { get :edit, params: { user_id: user, id: question.id } }
    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end
    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    sign_in_user
    context 'with valid attributes' do
      it 'saves the new question in the database' do
        expect { post :create, params: { user_id: user.id, question: attributes_for(:question) } }.to change(Question, :count).by(1)
      end
      it 'redirects to show view' do
        post :create, params: { user_id: user, question: attributes_for(:question) }
        expect(response).to redirect_to question_path(assigns[:question])
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new question in the database' do
        expect { post :create, params: { user_id: user, question: attributes_for(:invalid_question) } }.to_not change(Question, :count)
      end
      it 're-renders new view' do
        post :create, params: { user_id: user, question: attributes_for(:invalid_question) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    sign_in_user
    context 'valid attributes' do
      before { question }
      it 'assigns the requested question to @question' do
        patch :update, params: { user_id: user, id: question, question: attributes_for(:question) }
        expect(assigns(:question)).to eq question
      end
      it 'changes question attributes' do
        patch :update, params: { user_id: user, id: question.id, question: { title: 'new title', body: 'new body' } }
        question.reload
        expect(question.title).to eq 'new title'
        expect(question.body).to eq 'new body'
      end

      it 'redirects to the updated question' do
        patch :update, params: { user_id: user, id: question.id, question: attributes_for(:question) }
        expect(response).to redirect_to question
      end
    end

    context 'invalid attributes' do
      before { patch :update, params: { user_id: user, id: question.id, question: { title: 'new title', body: nil } } }
      it 'does not change question attributes' do
        question.reload
        expect(question.title).to eq 'MyString'
        expect(question.body).to eq 'MyText'
      end
      it 're-renders edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user
    before { question }
    it 'deletes question' do
      expect { delete :destroy, params: { id: question.id } }.to change(Question, :count).by(-1)
    end

    it 'redirects to index view' do
      delete :destroy, params: { id: question.id }
      expect(response).to redirect_to questions_path
    end
  end

  describe 'post #best_answer' do
    sign_in_user
    before { get :show, params: { user_id: user, id: question.id } }
    # before { question.answers }
    it 'chooses best answer' do
      post :best_answer, params: { question_id: question.id, answer_id: answer.id }, format: :js
      question.reload
      expect(question.best_answer).to be(answer.id)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'post #like' do
    sign_in_user
    before { get :show, params: { id: question.id } }
    it 'likes the question' do
      post :like, params: { question_id: question.id }, format: :js
      expect(question.votes.find_by(user_id: @user.id).like).to be(true)
    end
  end

  describe 'post #dislike' do
    sign_in_user
    before { get :show, params: { id: question.id } }
    it 'likes the question' do
      post :dislike, params: { question_id: question.id }, format: :js
      expect(question.votes.find_by(user_id: @user.id).dislike).to be(true)
    end
  end
end
