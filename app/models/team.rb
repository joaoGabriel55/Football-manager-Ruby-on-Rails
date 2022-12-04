class Team < ApplicationRecord
  validates :name, presence: true
  validates :stadium, presence: true
  validates :foundation, presence: true, numericality: {
                           greater_than_or_equal_to: 1700,
                           less_than_or_equal_to: Date.today.year,
                         }

  has_many :players
end
