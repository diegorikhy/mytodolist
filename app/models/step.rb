class Step < ApplicationRecord
  has_many :tasks, dependent: :destroy
  belongs_to :board

  validates :title, presence: { message: '^Preencha o título da Etapa!' }
  validates :board_id, presence: { message: '^A Etapa precisa estar em um Quadro!' }

  def to_obj
    {
      id:         id,
      title:      title,
      board_id:   board_id,
      created_at: created_at
    }
  end

  def to_show_obj
    attrbs = to_obj
    attrbs[:tasks] = tasks.map(&:to_obj)
    attrbs
  end
end
