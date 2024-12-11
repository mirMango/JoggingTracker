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
    time.to_f / 60 # Assuming time is in minutes, convert to hours
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
end
