class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :contents
      t.references :user, index: true
      t.references :job, index: true
      t.timestamps
    end
  end
end
