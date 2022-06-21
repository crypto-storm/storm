require 'rails_helper'

RSpec.describe ExchangesController, type: :controller do
  let(:exchange) { create(:exchange) }
  let(:exchange_params) { build(:exchange).slice('name') }

  describe 'GET index' do
    before { get :index }

    it 'assigns @exchanges' do
      expect(assigns[:exchanges]).to eq([exchange])
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET new' do
    before { get :new }

    it 'assigns @exchange' do
      expect(assigns[:exchange].equals?(Exchange.new)).to be true
    end

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'GET edit' do
    before { get :edit, params: { id: exchange.id } }

    it 'assigns @exchange' do
      expect(assigns[:exchange]).to eq(exchange)
    end

    it 'renders the edit template' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST create' do
    let(:request) { post :create, params: { exchange: exchange_params }, format: :turbo_stream }

    it 'assigns @exchange' do
      request

      expect(assigns[:exchange].equals?(Exchange.new(exchange_params))).to be true
    end

    it 'creates exchange' do
      expect { request }.to change(Exchange, :count).by(1)
    end

    it 'renders the create turbo stream template' do
      request

      expect(response).to render_template(:create)
    end
  end

  describe 'PUT update' do
    before do
      put :update, params: { id: exchange.id, exchange: exchange_params }, format: :turbo_stream
      exchange.reload
    end

    it 'assigns @exchange' do
      expect(assigns[:exchange]).to eq(exchange)
    end

    it 'updates exchange' do
      expect(exchange.name).to eq(exchange_params['name'])
    end

    it 'renders the update turbo stream template' do
      expect(response).to render_template(:update)
    end
  end

  describe 'DELETE destroy' do
    let(:request) { delete :destroy, params: { id: exchange.id }, format: :turbo_stream }

    before { exchange }

    it 'assigns @exchange' do
      request

      expect(assigns[:exchange]).to eq(exchange)
    end

    it 'deletes exchange' do
      expect { request }.to change(Exchange, :count).by(-1)
    end

    it 'renders the destroy turbo stream template' do
      request

      expect(response).to render_template(:destroy)
    end
  end
end
