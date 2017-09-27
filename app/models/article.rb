class Article < ApplicationRecord
  belongs_to :user
  paginates_per 12
end
