class Article < ApplicationRecord
  has_attached_file :image, styles: { medium: '400x600', thumb: '200x300' }
  validates_attachment :image, content_type: { content_type: /\Aimage\/.*\z/ },
                               size: { in: 0..5.megabytes }
  validates_presence_of :title, :text
  validates_length_of :title, maximum: 50
  belongs_to :user
  paginates_per 12
  resourcify
  default_scope { order('created_at DESC') }
end
