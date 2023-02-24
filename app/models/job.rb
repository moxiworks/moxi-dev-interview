class Job < ApplicationRecord
  belongs_to :event
  has_many :shifts, dependent: :destroy

  validates :name, presence: true
  validates :event, presence: true
end
