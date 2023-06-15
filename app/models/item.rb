class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :genre

  validates :genre_id, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
