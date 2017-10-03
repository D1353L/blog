require 'rails_helper'

RSpec.describe Article, :article, type: :model do
  describe 'associations' do
    it { should belong_to :user }
  end

  describe 'validations' do
    it { should have_attached_file(:image) }

    it {
      should validate_attachment_content_type(:image)
        .allowing('image/jpg', 'image/png', 'image/gif')
        .rejecting('text/plain', 'text/xml')
    }

    it { should validate_attachment_size(:image).less_than(5.megabytes) }
  end

  describe 'default scope' do
    before do
      users = [create(:admin), create(:copyriter)]
      @articles = Array.new(10) do
        create(:article, user: users.sample)
      end
    end

    it 'ordered descendingly' do
      expect(Article.all).to match_array @articles.reverse
    end
  end
end
