class CreateJoggingTimes < ActiveRecord::Migration[7.1]
  def change
    create_table :jogging_times do |t|
      t.date :date
      t.float :distance
      t.integer :time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
