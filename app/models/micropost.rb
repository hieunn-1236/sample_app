class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  scope :newest, ->{order(created_at: :desc)}
  validates :user_id, presence: true
  validates :content,
            presence: true,
            length: {maximum: Settings.settings.content_maximum_length}
  validates :image, content_type: {in: Settings.settings.image_type,
                                   message: :invalid_format},
            size: {less_than: Settings.settings.max_image_size.megabytes,
                   message: :large_size}

  def display_image
    image.variant resize_to_limit: [Settings.settings.mage_limit,
                                    Settings.settings.image_limit]
  end
end
