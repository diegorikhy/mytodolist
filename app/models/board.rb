class Board < ApplicationRecord
  has_many :steps, dependent: :destroy

  validates :title, presence: { message: '^Preencha o título do Quadro!' }

  def to_obj
    {
      title:      title,
      created_at: created_at
    }
  end

  def to_show_obj
    attrbs = to_obj
    attrbs[:steps] = steps.map(&:to_show_obj)
    attrbs
  end
end
