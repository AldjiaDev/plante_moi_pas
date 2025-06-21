class QuizController < ApplicationController
  before_action :authenticate_user!

  def start
    # On choisit 5 questions aléatoires
    session[:quiz_question_ids] = QuizQuestion.pluck(:id).sample(5)
    session[:current_index] = 0
    session[:correct_answers] = 0

    redirect_to quiz_show_path
  end

  def show
    index = session[:current_index]
    question_ids = session[:quiz_question_ids]

    if index.nil? || question_ids.nil?
      redirect_to quiz_start_path, alert: "Commence le quiz d'abord !"
      return
    end

    if index >= question_ids.length
      redirect_to quiz_result_path
      return
    end

    @question = QuizQuestion.find(question_ids[index])
    @options = JSON.parse(@question.options)
  end

  def answer
    index = session[:current_index]
    question_ids = session[:quiz_question_ids]
    selected_answer = params[:answer]

    if index.nil? || question_ids.nil?
      redirect_to quiz_start_path, alert: "Commence le quiz d'abord !"
      return
    end

    current_question = QuizQuestion.find(question_ids[index])

    correct = (selected_answer == current_question.answer)

    # Enregistre la réponse de l'utilisateur
    UserQuizAnswer.create!(
      user: current_user,
      quiz_question: current_question,
      given_answer: selected_answer,
      correct: correct
    )

    session[:correct_answers] += 1 if correct
    session[:current_index] += 1

    if session[:current_index] >= question_ids.length
      redirect_to quiz_result_path
    else
      redirect_to quiz_show_path
    end
  end

  def result
    @correct_answers = session[:correct_answers] || 0

    if @correct_answers == 5
      current_user.increment!(:leaves)
      flash.now[:notice] = "Bravo ! Tu as gagné 1 feuille 🍃"
    else
      flash.now[:alert] = "Tu as eu #{@correct_answers}/5 bonnes réponses. Retente ta chance !"
    end

    # Reset session
    session[:quiz_question_ids] = nil
    session[:current_index] = nil
    session[:correct_answers] = nil
  end
end
