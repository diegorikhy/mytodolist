class Task < ApplicationRecord
  belongs_to :step

  validates :title, presence: { message: 'Preencha o título da Tarefa!' }
  validates :step_id, presence: { message: 'A Tarefa precisa estar em uma Etapa!' }

  def to_obj
    {
      id:         id,
      title:      title,
      step_id:    step_id,
      created_at: created_at
    }
  end
end
