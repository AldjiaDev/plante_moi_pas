class CreateUserQuizAnswers < ActiveRecord::Migration[7.2]
  def change
    create_table :user_quiz_answers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :quiz_question, null: false, foreign_key: true
      t.string :given_answer
      t.boolean :correct

      t.timestamps
    end
  end
end
