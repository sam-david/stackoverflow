require 'rails_helper'

RSpec.describe QuestionsController, :type => :controller do
  describe 'GET index' do
    before do
      Question.delete_all
    end

    it "returns response 200" do
      get :index
      expect(response).to be_success
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "loads all the questions" do
      question1, question2 = Question.create!, Question.create!
      get :index
      expect(assigns(:questions)).to match_array([question1, question2])
    end
  end

  describe 'GET show' do
    before(:each) do
      Question.delete_all
      @question_doge = Question.create!
    end

    it "returns response 200" do
      get :show, {id: @question_doge}
      expect(response).to be_success
    end

    it "renders the show template" do
      get :show, {id: @question_doge}
      expect(response).to render_template("show")
    end

    it "loads the question" do
      get :show, {id: @question_doge}
      expect(assigns(:question)).to eq(@question_doge)
    end
  end

  describe 'POST create' do
    before(:each) do
      Question.delete_all
      @question_doge = Question.create!
    end

    it "creates a new question" do
      expect { post :create, question: {title: 'so doge', content: 'much text'} }.to change(Question,:count).by(1)
    end

    it "redirects to the new question page" do
      post :create, question: {title: 'so doge', content: 'much text'}
      expect(response).to redirect_to Question.last
    end
  end

  describe "PATCH update" do
    before(:each) do
      Question.delete_all
      @question_doge = Question.create(title: 'so old', content: 'much updating')
      @attr = {title: 'new doge', content: 'such new'}
    end

    it 'changes the title of the question' do
      patch :update, id: @question_doge, question: @attr
      @question_doge.reload
      expect(@question_doge.title).to eq(@attr[:title])
    end
  end

  describe "PUT upvote and dowvote" do
    before(:each) do
      Question.delete_all
      @question_doge = Question.create(title: 'so vote', content: 'much upvote')
    end

    it 'upvote increments the vote count by 1' do
      put :upvote, id: @question_doge
      @question_doge.reload
      expect(@question_doge.vote).to eq(1)
    end

    it 'downvote decrements the vote count by 1' do
      put :downvote, id: @question_doge
      @question_doge.reload
      expect(@question_doge.vote).to eq(-1)
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      Question.delete_all
      @question_test = Question.create!
    end

    it 'deletes the question' do
      expect { delete :destroy, id: @question_test}.to change(Question,:count).by(-1)
    end
  end

end
