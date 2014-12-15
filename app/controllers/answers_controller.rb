class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params)
    respond_to do |format|
      if @answer.save
        format.html { redirect_to @answer, notice: 'Answer was successfully created.' }
        format.js   {}
        format.json { render json: @answer, status: :created, location: @question }
      else
        format.html { render action: "new" }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  def upvote
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:answer_id])

    @answer.vote += 1
    respond_to do |format|
      if @answer.save
        format.html { redirect_to @answer, notice: 'Question successfully upvoted.' }
        format.js   {}
        format.json { render json: @answer, status: :created, location: @answer }
      else
        format.html { render action: "new" }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end

  end

  def downvote
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:answer_id])

    @answer.vote -= 1
    respond_to do |format|
      if @answer.save
        format.html { redirect_to @answer, notice: 'Question successfully upvoted.' }
        format.js   {}
        format.json { render json: @answer, status: :created, location: @answer }
      else
        format.html { render action: "new" }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end

  end

  private
    def answer_params
      params.require(:answer).permit(:title, :content)
    end
end
