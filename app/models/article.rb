class Article < ApplicationRecord
  has_attached_file :image, styles: { medium: '400x600', thumb: '200x300' }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  belongs_to :user
  paginates_per 12
  resourcify
  default_scope { order('created_at DESC') }
end
