class Article < ApplicationRecord
  belongs_to :user
  paginates_per 12
  resourcify
  default_scope { order('created_at DESC') }
end
