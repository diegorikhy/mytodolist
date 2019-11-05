require 'rails_helper'

RSpec.describe Step, type: :model do
  context 'validation tests' do
    it 'ensure title present' do
      step = build(:step)
      step.title = nil
      expect(step.valid?).to eq(false)
    end

    it 'ensure pertence to board' do
      step = build(:step)
      step.board_id = nil
      expect(step.valid?).to eq(false)
    end
  end

  context 'instance methods' do
    it 'to_obj should return hash' do
      step = build_stubbed(:step).to_obj
      expect(step.class).to eq(Hash)
    end
  end
end
