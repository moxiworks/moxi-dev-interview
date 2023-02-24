class Shift < ApplicationRecord
  belongs_to :job

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :start_time, format: {with: /\A\d{2}:\d{2}\z/, message: "must be in 24hr HH:MM format"}
  validates :end_time, format: {with: /\A\d{2}:\d{2}\z/, message: "must be in 24hr HH:MM format"}
  validates :start_time, comparison: {less_than: :end_time}
  validates :job, presence: true

  def start_date_time
    GetDateTime.call(job.event.date, start_time)
  end

  def end_date_time
    GetDateTime.call(job.event.date, end_time)
  end
end
