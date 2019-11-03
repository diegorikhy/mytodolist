class Board < ApplicationRecord
  has_many :steps, dependent: :destroy

  validates :title, presence: { message: '^Preencha o título do Quadro!' }

  def to_obj
    {
      id:         id,
      title:      title,
      created_at: created_at
    }
  end

  def to_show_obj
    attrbs = to_obj
    attrbs[:steps] = steps.order(:created_at).map(&:to_show_obj)
    attrbs
  end
end
