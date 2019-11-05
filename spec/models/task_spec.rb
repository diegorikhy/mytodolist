require 'rails_helper'

RSpec.describe Task, type: :model do
  context 'validation tests' do
    it 'ensure title present' do
      task = build(:task)
      task.title = nil
      expect(task.valid?).to eq(false)
    end

    it 'ensure pertence to step' do
      task = build(:task)
      task.step_id = nil
      expect(task.valid?).to eq(false)
    end
  end

  context 'instance methods' do
    it 'to_obj should return hash' do
      task = build_stubbed(:task).to_obj
      expect(task.class).to eq(Hash)
    end
  end
end
