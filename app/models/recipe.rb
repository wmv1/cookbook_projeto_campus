class Recipe < ApplicationRecord
  belongs_to :recipe_type
  belongs_to :cuisine
  belongs_to :user

  has_attached_file :image
  validates_attachment_content_type :image, content_type: "image/jpeg", message:  'Tipo da imagem não é válido'


  validates :title, :cuisine, :difficulty, :cook_time,
            :ingredients, :cook_method, presence: true

  def cook_time_min
    "#{cook_time} minutos"
  end
end
