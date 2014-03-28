class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.text :contents
      t.string :email

      t.timestamps
    end
  end
end
