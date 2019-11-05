require 'rails_helper'

RSpec.describe Board, type: :model do
  context 'validation tests' do
    it 'ensure title present' do
      board = build(:board)
      board.title = nil
      expect(board.valid?).to eq(false)
    end

    it 'should save successfully' do
      board = build(:board).save
      expect(board).to eq(true)
    end
  end

  context 'instance methods' do
    it 'to_obj should return hash' do
      board = build_stubbed(:board).to_obj
      expect(board.class).to eq(Hash)
    end
  end
end
