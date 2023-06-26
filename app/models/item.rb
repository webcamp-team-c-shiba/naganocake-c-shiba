class Item < ApplicationRecord
  has_one_attached :image

  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_item

  validates :genre_id, presence: true
  validates :image, presence: true
  validates_format_of :image, with: /\A.*\.(png|jpg|jpeg|gif)\z/i, message: "(PNG, JPG, JPEG, GIF)ファイルを選択してください"
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def get_item_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  # 消費税
  def with_tax_price
    (price * 1.1).floor
  end
  
  # 小計
  def subtotal
    with_tax_price * amount
  end
  
  # ヘッダーの検索機能
  def self.looks(word)
    Item.where('name LIKE?', "%#{word}%" )
  end

end
