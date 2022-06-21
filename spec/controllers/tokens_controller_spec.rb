require 'rails_helper'

RSpec.describe TokensController, type: :controller do
  let(:token) { create(:token) }
  let(:token_params) { build(:token).slice('name', 'abbr') }

  describe 'GET index' do
    before { get :index }

    it 'assigns @tokens' do
      expect(assigns[:tokens]).to eq([token])
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET new' do
    before { get :new }

    it 'assigns @token' do
      expect(assigns[:token].equals?(Token.new)).to be true
    end

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'GET edit' do
    before { get :edit, params: { id: token.id } }

    it 'assigns @token' do
      expect(assigns[:token]).to eq(token)
    end

    it 'renders the edit template' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST create' do
    let(:request) { post :create, params: { token: token_params }, format: :turbo_stream }

    it 'assigns @token' do
      request

      expect(assigns[:token].equals?(Token.new(token_params))).to be true
    end

    it 'creates token' do
      expect { request }.to change(Token, :count).by(1)
    end

    it 'renders the create turbo stream template' do
      request

      expect(response).to render_template(:create)
    end
  end

  describe 'PUT update' do
    before do
      put :update, params: { id: token.id, token: token_params }, format: :turbo_stream
      token.reload
    end

    it 'assigns @token' do
      expect(assigns[:token]).to eq(token)
    end

    it 'updates token' do
      expect(token.name).to eq(token_params['name'])
    end

    it 'renders the update turbo stream template' do
      expect(response).to render_template(:update)
    end
  end

  describe 'DELETE destroy' do
    let(:request) { delete :destroy, params: { id: token.id }, format: :turbo_stream }

    before { token }

    it 'assigns @token' do
      request

      expect(assigns[:token]).to eq(token)
    end

    it 'deletes token' do
      expect { request }.to change(Token, :count).by(-1)
    end

    it 'renders the destroy turbo stream template' do
      request

      expect(response).to render_template(:destroy)
    end
  end
end

