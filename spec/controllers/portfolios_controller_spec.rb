require 'rails_helper'

RSpec.describe PortfoliosController, type: :controller do
  include Rails.application.routes.url_helpers

  let(:portfolio) { create(:portfolio) }
  let(:portfolio_params) { build(:portfolio).slice('name') }

  describe 'GET new' do
    before { get :new }

    it 'assigns @portfolio' do
      expect(assigns[:portfolio].equals?(Portfolio.new)).to be true
    end

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'GET edit' do
    before { get :edit, params: { id: portfolio.id } }

    it 'assigns @portfolio' do
      expect(assigns[:portfolio]).to eq(portfolio)
    end

    it 'renders the edit template' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST create' do
    let(:request) { post :create, params: { portfolio: portfolio_params }, format: :turbo_stream }

    it 'assigns @portfolio' do
      request

      expect(assigns[:portfolio].equals?(Portfolio.new(portfolio_params))).to be true
    end

    it 'creates portfolio' do
      expect { request }.to change(Portfolio, :count).by(1)
    end

    it 'renders the create turbo stream template' do
      request

      expect(response).to render_template(:create)
    end
  end

  describe 'PUT update' do
    before do
      put :update, params: { id: portfolio.id, portfolio: portfolio_params }, format: :turbo_stream
      portfolio.reload
    end

    it 'assigns @portfolio' do
      expect(assigns[:portfolio]).to eq(portfolio)
    end

    it 'updates portfolio' do
      expect(portfolio.name).to eq(portfolio_params['name'])
    end

    it 'renders the update turbo stream template' do
      expect(response).to render_template(:update)
    end
  end

  describe 'DELETE destroy' do
    let(:request) { delete :destroy, params: { id: portfolio.id }, format: :turbo_stream }

    before { portfolio }

    it 'assigns @portfolio' do
      request

      expect(assigns[:portfolio]).to eq(portfolio)
    end

    it 'deletes portfolio' do
      expect { request }.to change(Portfolio, :count).by(-1)
    end

    it 'renders the destroy turbo stream template' do
      request

      expect(response).to render_template(:destroy)
    end
  end

  describe 'PUT change_active' do
    let(:request) { put :change_active, params: { id: portfolio.id } }

    it 'changes portfolio id on session' do
      expect { request }.to change { session['portfolio_id'] }.to(portfolio.id.to_s)
    end

    it 'redirects to overview_index_path' do
      expect(request).to redirect_to(overview_index_path)
    end
  end
end
