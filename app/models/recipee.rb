class Recipee < ApplicationRecord
  validates :cooking_time, numericality: { greater_than_or_equal_to: 0 }
  validates :preparation_time, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :user
  has_many :recipe_foods
  has_many :foods, through: :recipe_foods
end
