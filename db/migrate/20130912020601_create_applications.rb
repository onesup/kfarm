class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.references :mentee, index: true
      t.references :job, index: true
      t.boolean :confirm
      t.datetime :confirmed_at

      t.timestamps
    end
  end
end
