class Event < ApplicationRecord
  has_many :jobs, dependent: :destroy

  validates :name, presence: true
  validates :date, presence: true
  validates :date, format: {with: /\A\d{4}-\d{2}-\d{2}\z/, message: "must be in YYYY-MM-DD format"}
end
