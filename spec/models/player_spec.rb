# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Player do
  context 'validate Player' do
    it 'invalid age' do
      expect(described_class.new(name: 'Lionel', age: 15, position: 'Forward', overall: 98)).not_to be_valid
    end

    it 'invalid overall' do
      expect(described_class.new(name: 'Lionel', age: 17, position: 'Forward', overall: 0)).not_to be_valid
    end
  end
end
