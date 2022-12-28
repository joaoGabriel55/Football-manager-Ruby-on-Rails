# frozen_string_literal: true

class Player < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: { greater_than_or_equal_to: 16 }
  validates :position, presence: true
  validates :overall, presence: true, numericality: { greater_than: 0 }

  belongs_to :team, optional: true

  def plays_for
    return if team.blank?

    team.name
  end
end
