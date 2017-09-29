class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  rolify
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
end
