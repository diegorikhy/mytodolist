class Board < ApplicationRecord
  has_many :steps, dependent: :destroy

  validates :title, presence: { message: 'Preencha o título do quadro!' }
end
