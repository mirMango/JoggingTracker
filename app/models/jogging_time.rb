class JoggingTime < ApplicationRecord
  belongs_to :user

  validates :date, presence: true
  validates :distance, presence: true, numericality: { greater_than: 0 }
  validates :time, presence: true, numericality: { greater_than: 0 }
  validates :distance_unit, presence: true, inclusion: { in: %w(meters kilometers) }

  def average_speed
    distance_in_kilometers / time_in_hours
  end

  def time_in_hours
    time.to_f / 60
  end

  def distance_in_kilometers
    if distance_unit == 'kilometers'
      distance
    elsif distance_unit == 'meters'
      distance / 1000.0
    else
      distance
    end
  end

  def self.weekly_averages(user)
    user.jogging_times.group_by_week(:date).select(
      'date, SUM(distance) AS total_distance, SUM(time) AS total_time'
    ).map do |week|
      total_distance = week.total_distance
      total_time_in_hours = week.total_time / 60.0
      avg_speed = total_distance / total_time_in_hours
      
      {
        week: week.date.strftime("%U, %Y"),
        avg_distance: total_distance,
        avg_speed: avg_speed
      }
    end
  end
end
