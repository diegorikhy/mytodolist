class Task < ApplicationRecord
  belongs_to :step

  validates :title, presence: { message: 'Preencha o título da Tarefa!' }
end
