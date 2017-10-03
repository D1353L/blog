require 'rails_helper'

RSpec.describe CopyritersController, type: :controller do
  let(:copyriter) { create(:copyriter) }
  let(:admin) { create(:admin) }

  describe 'GET #new' do
    context 'authenticated' do
      context "as admin" do
        before(:each) { sign_in admin }

        it 'returns a success response' do
          get :new
          expect(response).to be_success
        end
      end

      context "as copyriter" do
        before(:each) { sign_in copyriter }

        it 'raises an authorization error' do
          expect { get :new }.to raise_error(CanCan::AccessDenied)
        end
      end
    end

    context 'not authenticated' do
      it 'raises an authorization error' do
        expect { get :new }.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) do
      {
        email: FFaker::Internet.email,
        password: FFaker::Internet.password
      }
    end
    let(:invalid_attributes) { build(:invalid_copyriter).attributes }

    before(:each) { create(:copyriter_role) }

    context 'authenticated' do
      context "as admin" do
        before(:each) { sign_in admin }

        context 'with valid params' do
          it 'creates a new copyriter' do
            expect {
              post :create, params: { user: valid_attributes }
            }.to change(User, :count).by(1)
          end

          it 'redirects to dashboard' do
            post :create, params: { user: valid_attributes }
            expect(response).to redirect_to dashboard_url
          end
        end

        context 'with invalid params' do
          it "returns a success response (i.e. to display the 'new' template)" do
            post :create, params: { user: invalid_attributes }
            expect(response).to be_success
          end
        end
      end

      context "as copyriter" do
        before(:each) { sign_in copyriter }

        it 'raises an authorization error' do
          expect { post :create, params: { user: valid_attributes } }
            .to raise_error(CanCan::AccessDenied)
        end
      end
    end

    context 'not authenticated' do
      it 'raises an authorization error' do
        expect { post :create, params: { article: valid_attributes } }
          .to raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'authenticated' do
      context 'as admin' do
        before(:each) { sign_in admin }

        it 'destroys the requested copyriter' do
          copyriter
          expect { delete :destroy, params: { id: copyriter.to_param } }
            .to change(User, :count).by(-1)
        end

        it 'redirects to dashboard' do
          delete :destroy, params: { id: copyriter.to_param }
          expect(response).to redirect_to(dashboard_url)
        end
      end

      context "as copyriter" do
        before(:each) { sign_in copyriter }

        it 'raises an authorization error' do
          expect { delete :destroy, params: { id: copyriter.to_param } }
            .to raise_error(CanCan::AccessDenied)
        end
      end
    end

    context 'not authenticated' do
      it 'raises an authorization error' do
        expect { delete :destroy, params: { id: copyriter.to_param } }
          .to raise_error(CanCan::AccessDenied)
      end
    end
  end
end
