require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  let(:admin) { create(:admin) }
  let(:copyriter) { create(:copyriter) }

  before do
    @copyriter_articles = Array.new(5) { create(:article, user: copyriter) }
    @admin_articles = Array.new(5) { create(:article, user: admin) }
  end

  describe 'GET #index' do
    context 'authenticated' do
      context 'as admin' do
        before(:each) do
          sign_in admin
          get :index
        end

        it 'returns a success response' do
          expect(response).to be_success
        end

        it 'assigns @copyriters' do
          expect(assigns(:copyriters)).to match_array [copyriter]
        end

        it 'assigns @articles' do
          expect(assigns(:articles))
            .to match_array @copyriter_articles + @admin_articles
        end
      end

      context 'as copyriter' do
        before(:each) do
          sign_in copyriter
          get :index
        end

        it 'returns a success response' do
          expect(response).to be_success
        end

        it 'not assigns @copyriters' do
          expect(assigns(:copyriters)).to be_empty
        end

        it 'assigns own @articles' do
          expect(assigns(:articles))
            .to match_array @copyriter_articles
        end
      end
    end

    context 'not authenticated' do
      it 'raises an authorization error' do
        expect { get :index }
          .to raise_error(CanCan::AccessDenied)
      end
    end
  end
end
