require 'rails_helper'

RSpec.describe User, :user, type: :model do
  describe 'associations' do
    it { should have_many(:articles).dependent(:destroy) }
  end
end
