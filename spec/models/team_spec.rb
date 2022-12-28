# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Team do
  context 'validate Team' do
    it 'invalid foundation' do
      expect(described_class.new(name: 'Barça', stadium: 'Camp Nou', foundation: 1200)).not_to be_valid

      next_year = Date.today.year + 1

      expect(described_class.new(name: 'Barça', stadium: 'Camp Nou', foundation: next_year)).not_to be_valid
    end
  end
end
