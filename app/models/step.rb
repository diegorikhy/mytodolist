class Step < ApplicationRecord
  has_many :tasks, dependent: :destroy
  belongs_to :board

  validates :title, presence: { message: 'Preencha o título da Etapa!' }
end
