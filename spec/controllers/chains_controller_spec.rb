require 'rails_helper'

RSpec.describe ChainsController, type: :controller do
  let(:chain) { create(:chain) }
  let(:chain_params) { build(:chain).slice('name') }

  describe 'GET index' do
    before { get :index }

    it 'assigns @chains' do
      expect(assigns[:chains]).to eq([chain])
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET new' do
    before { get :new }

    it 'assigns @chain' do
      expect(assigns[:chain].equals?(Chain.new)).to be true
    end

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'GET edit' do
    before { get :edit, params: { id: chain.id } }

    it 'assigns @chain' do
      expect(assigns[:chain]).to eq(chain)
    end

    it 'renders the edit template' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST create' do
    let(:request) { post :create, params: { chain: chain_params }, format: :turbo_stream }

    it 'assigns @chain' do
      request

      expect(assigns[:chain].equals?(Chain.new(chain_params))).to be true
    end

    it 'creates chain' do
      expect { request }.to change(Chain, :count).by(1)
    end

    it 'renders the create turbo stream template' do
      request

      expect(response).to render_template(:create)
    end
  end

  describe 'PUT update' do
    before do
      put :update, params: { id: chain.id, chain: chain_params }, format: :turbo_stream
      chain.reload
    end

    it 'assigns @chain' do
      expect(assigns[:chain]).to eq(chain)
    end

    it 'updates chain' do
      expect(chain.name).to eq(chain_params['name'])
    end

    it 'renders the update turbo stream template' do
      expect(response).to render_template(:update)
    end
  end

  describe 'DELETE destroy' do
    let(:request) { delete :destroy, params: { id: chain.id }, format: :turbo_stream }

    before { chain }

    it 'assigns @chain' do
      request

      expect(assigns[:chain]).to eq(chain)
    end

    it 'deletes chain' do
      expect { request }.to change(Chain, :count).by(-1)
    end

    it 'renders the destroy turbo stream template' do
      request

      expect(response).to render_template(:destroy)
    end
  end
end
