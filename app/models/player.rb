class Player < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: { greater_than_or_equal_to: 16 }
  validates :position, presence: true
  validates :overall, presence: true, numericality: { greater_than: 0 }
end