class QuestionsController < ApplicationController

  def index
    @questions = Question.all.sort_by(&:created_at).reverse
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers
  end

  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.js   {}
        format.json { render json: @question, status: :created, location: @question }
      else
        format.html { render action: "new" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end

    # @question.save
    # redirect_to @question
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    redirect_to questions_path
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])

    if @question.update(question_params)
      redirect_to @question
    else
      render 'edit'
    end
  end

  def upvote
    @question = Question.find(params[:id])

    @question.vote += 1

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question successfully upvoted.' }
        format.js   {}
        format.json { render json: @question, status: :created, location: @question }
      else
        format.html { render action: "new" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end

  end

  def downvote
    @question = Question.find(params[:id])

    @question.vote -= 1
    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question successfully upvoted.' }
        format.js   {}
        format.json { render json: @question, status: :created, location: @question }
      else
        format.html { render action: "new" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def question_params
    params.require(:question).permit(:title, :content)
  end
end
