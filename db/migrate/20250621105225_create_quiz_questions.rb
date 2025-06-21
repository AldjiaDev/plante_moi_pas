class CreateQuizQuestions < ActiveRecord::Migration[7.2]
  def change
   create_table :quiz_questions do |t|
      t.text :question, null: false
      t.string :answer, null: false
      t.text :options, null: false  # stocke un JSON d'options
      t.timestamps
    end
  end
end
