class AddDistanceUnitToJoggingTimes < ActiveRecord::Migration[7.1]
  def change
    add_column :jogging_times, :distance_unit, :string
  end
end
