class Volunteer < ApplicationRecord
  validates :email, presence: true, uniqueness: true
end
