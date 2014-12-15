require 'rails_helper'

RSpec.describe AnswersController, :type => :controller do
  describe 'POST create' do
    before(:each) do
      Answer.delete_all
      @question_doge = Question.create!
      @question_doge.answers << Answer.create!
    end

    it "creates a new answer" do
      expect { post :create, :question_id => @question_doge, answer: {title: 'so answer', content: 'much was mystery'} }.to change(Answer,:count).by(1)
    end

    it "redirects to the new question page" do
      post :create, :question_id => @question_doge, answer: {title: 'so doge', content: 'much text'}
      expect(response).to redirect_to @question_doge
    end
  end

  describe "PUT upvote and dowvote" do
    before(:each) do
      Question.delete_all
      Answer.delete_all
      @question_doge = Question.create!
      @question_doge.answers << Answer.create!
      @answer_doge = Answer.first
    end

    it 'upvote increments the vote count by 1' do
      put :upvote, {question_id: @question_doge, answer_id: @answer_doge}
      @answer_doge.reload
      expect(@answer_doge.vote).to eq(1)
    end

    it 'downvote decrements the vote count by 1' do
      put :downvote, {question_id: @question_doge, answer_id: @answer_doge}
      @answer_doge.reload
      expect(@answer_doge.vote).to eq(-1)
    end
  end

end
