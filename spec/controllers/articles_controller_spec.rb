require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  let(:copyriter) { create(:copyriter) }
  let(:admin) { create(:admin) }

  let(:admin_article) { create(:article, user: admin) }
  let(:copyriter_article) { create(:article, user: copyriter) }

  describe 'GET #index' do
    it 'returns a success response' do
      admin_article
      copyriter_article
      get :index
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    %i[admin_article copyriter_article].each do |article|
      context article.to_s do
        it 'returns a success response' do
          get :show, params: { id: send(article).to_param }
          expect(response).to be_success
        end
      end
    end
  end

  describe 'GET #new' do
    context 'authenticated' do
      %i[admin copyriter].each do |user|
        context "as #{user}" do
          before(:each) { sign_in send user }

          it 'returns a success response' do
            get :new
            expect(response).to be_success
          end
        end
      end
    end

    context 'not authenticated' do
      it 'raises an authorization error' do
        expect { get :new }.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe 'GET #edit' do
    context 'authenticated' do
      context 'own article' do
        %i[admin copyriter].each do |user|
          context "as #{user}" do
            before(:each) { sign_in send user }

            it 'returns a success response' do
              get :edit, params: { id: send("#{user}_article").to_param }
              expect(response).to be_success
            end
          end
        end
      end

      context "another's article" do
        context 'as admin' do
          before(:each) { sign_in admin }

          it 'returns a success response' do
            get :edit, params: { id: copyriter_article.to_param }
            expect(response).to be_success
          end
        end

        context 'as copyriter' do
          before(:each) { sign_in copyriter }

          it 'raises an authorization error' do
            expect { get :edit, params: { id: admin_article.to_param } }
              .to raise_error(CanCan::AccessDenied)
          end
        end
      end
    end

    context 'not authenticated' do
      %i[admin copyriter].each do |user|
        context "#{user}'s article" do
          it 'raises an authorization error' do
            expect { get :edit, params: { id: send("#{user}_article").to_param } }
              .to raise_error(CanCan::AccessDenied)
          end
        end
      end
    end
  end

  describe 'POST #create' do
    context 'authenticated' do
      %i[admin copyriter].each do |user|
        context "as #{user}" do
          before(:each) { sign_in send user }
          let(:valid_attributes) { build(:article, user: send(user)).attributes }
          let(:invalid_attributes) { build(:invalid_article, user: send(user)).attributes }

          context 'with valid params' do
            it 'creates a new Article' do
              expect {
                post :create, params: { article: valid_attributes }
              }.to change(Article, :count).by(1)
            end

            it 'redirects to the created article' do
              post :create, params: { article: valid_attributes }
              expect(response).to redirect_to(Article.last)
            end
          end

          context 'with invalid params' do
            it "returns a success response (i.e. to display the 'new' template)" do
              post :create, params: { article: invalid_attributes }
              expect(response).to be_success
            end
          end
        end
      end
    end

    context 'not authenticated' do
      let(:valid_attributes) { build(:article, user: copyriter).attributes }

      it 'raises an authorization error' do
        expect { post :create, params: { article: valid_attributes } }
          .to raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe 'PUT #update' do
    let(:new_attributes) { {'title' => 'new name', 'text' => 'new text'} }

    context 'authenticated' do
      %i[admin copyriter].each do |user|
        context 'own article' do
          let(:valid_attributes) { send("#{user}_article").attributes }

          context "as #{user}" do
            before(:each) { sign_in send user }
            let(:invalid_attributes) { build(:invalid_article, user: send(user)).attributes }

            context 'with valid params' do
              it 'updates the requested article' do
                put :update, params: { id: send("#{user}_article").to_param, article: new_attributes }
                send("#{user}_article").reload
                expect(send("#{user}_article").attributes).to include new_attributes
              end

              it 'redirects to the article' do
                put :update, params: { id: send("#{user}_article").to_param, article: valid_attributes }
                expect(response).to redirect_to(send("#{user}_article"))
              end
            end

            context 'with invalid params' do
              it "returns a success response (i.e. to display the 'edit' template)" do
                put :update, params: { id: send("#{user}_article").to_param, article: invalid_attributes }
                expect(response).to be_success
              end
            end
          end
        end
      end

      context "another's article" do
        context 'as admin' do
          before(:each) { sign_in admin }
          let(:valid_attributes) { admin_article.attributes }
          let(:invalid_attributes) { build(:invalid_article, user: admin).attributes }

          context 'with valid params' do
            it 'updates the requested article' do
              put :update, params: { id: copyriter_article.to_param, article: new_attributes }
              copyriter_article.reload
              expect(copyriter_article.attributes).to include new_attributes
            end

            it 'redirects to the article' do
              put :update, params: { id: copyriter_article.to_param, article: valid_attributes }
              expect(response).to redirect_to(copyriter_article)
            end
          end

          context 'with invalid params' do
            it "returns a success response (i.e. to display the 'edit' template)" do
              put :update, params: { id: copyriter_article.to_param, article: invalid_attributes }
              expect(response).to be_success
            end
          end
        end

        context 'as copyriter' do
          before(:each) { sign_in copyriter }

          it 'raises an authorization error' do
            expect {
              put :update, params: {
                id: admin_article.to_param,
                article: new_attributes
              }
            }.to raise_error(CanCan::AccessDenied)
          end
        end
      end
    end

    context 'not authenticated' do
      it 'raises an authorization error' do
        expect {
          put :update, params: {
            id: admin_article.to_param,
            article: new_attributes
          }
        }.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'authenticated' do
      context 'as admin' do
        before(:each) { sign_in admin }

        context 'own article' do
          it 'destroys the requested article' do
            admin_article
            expect { delete :destroy, params: { id: admin_article.to_param } }
              .to change(Article, :count).by(-1)
          end

          it 'redirects to the articles list' do
            delete :destroy, params: { id: admin_article.to_param }
            expect(response).to redirect_to(articles_url)
          end
        end

        context "another's article" do
          it 'destroys the requested article' do
            copyriter_article
            expect {
              delete :destroy, params: { id: copyriter_article.to_param }
            }.to change(Article, :count).by(-1)
          end

          it 'redirects to the articles list' do
            delete :destroy, params: { id: copyriter_article.to_param }
            expect(response).to redirect_to(articles_url)
          end
        end
      end

      context 'as copyriter' do
        before(:each) { sign_in copyriter }

        context 'own article' do
          it 'raises an authorization error' do
            expect { delete :destroy, params: { id: copyriter_article.to_param } }
              .to raise_error(CanCan::AccessDenied)
          end
        end

        context "another's article" do
          it 'raises an authorization error' do
            expect { delete :destroy, params: { id: admin_article.to_param } }
              .to raise_error(CanCan::AccessDenied)
          end
        end
      end
    end

    context 'not authenticated' do
      it 'raises an authorization error' do
        expect { delete :destroy, params: { id: copyriter_article.to_param } }
          .to raise_error(CanCan::AccessDenied)
      end
    end
  end
end
