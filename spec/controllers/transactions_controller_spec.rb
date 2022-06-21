require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  let(:portfolio) { create(:portfolio) }
  let(:token) { create(:token) }
  let(:location) { create(:chain) }
  let(:date) { DateTime.now }
  let(:rate) { 1 }

  let(:trade) { build(:transaction, :trade, portfolio:, token:, date:, rate:) }
  let(:tx_in_params) do
    build(:transaction, :purchase, token:, location:, rate:, amount: 100).tx_in.slice('amount', 'rate', 'location', 'token_id')
  end

  let(:tx_out_params) do
    build(:transaction, :sale, token:, location:, rate:, amount: 100).tx_out.slice('amount', 'rate', 'location', 'token_id')
  end

  before do
    create(:transaction, :purchase, portfolio:, token:, amount: 10_000)
    PortfolioOverviews.refresh
  end

  def build_params_for_form(tx_params)
    params = tx_params.dup
    params['location'] = params['location'].id_with_type
    params
  end

  describe 'GET new' do
    before { get :new }

    it 'assigns @transaction' do
      expect(assigns[:transaction].equals?(Transaction.new)).to be true
    end

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'GET edit' do
    before do
      trade.save!

      get :edit, params: { id: trade.id }
    end

    it 'assigns @transaction' do
      expect(assigns[:transaction]).to eq(trade)
    end

    it 'renders the edit template' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST create' do
    let(:request) do
      post :create,
           params: {
             transaction: {
               tx_in: build_params_for_form(tx_in_params),
               tx_out: build_params_for_form(tx_out_params),
               date:
             }
           },
           format: :turbo_stream
    end

    before do
      portfolio
      trade.save!
    end

    it 'assigns @transaction' do
      request

      transaction = Transaction.new(date: trade.date, portfolio:)
      transaction.build_tx_in(tx_in_params)
      transaction.build_tx_out(tx_out_params)
      transaction.tx_out.amount = -transaction.tx_out.amount
      expect(assigns[:transaction].equals?(transaction)).to be true
    end

    it 'creates transaction' do
      expect { request }.to change(Transaction, :count).by(1)
    end

    it 'renders the create turbo stream template' do
      request

      expect(response).to render_template(:create)
    end
  end

  describe 'PUT update' do
    before do
      trade.save!

      put :update,
          params: { id: trade.id,
                    transaction: { tx_in: build_params_for_form(tx_in_params),
                                   tx_out: build_params_for_form(tx_out_params) } },
          format: :turbo_stream

      trade.reload
    end

    it 'assigns @transaction' do
      expect(assigns[:transaction]).to eq(trade)
    end

    it 'updates transaction' do
      expect(trade.tx_in.amount).to eq(tx_in_params['amount'])
    end

    it 'renders the update turbo stream template' do
      expect(response).to render_template(:update)
    end
  end

  describe 'DELETE destroy' do
    let(:request) { delete :destroy, params: { id: trade.id }, format: :turbo_stream }

    before { trade.save! }

    it 'assigns @transaction' do
      request

      expect(assigns[:transaction]).to eq(trade)
    end

    it 'deletes transaction' do
      expect { request }.to change(Transaction, :count).by(-1)
    end

    it 'renders the destroy turbo stream template' do
      request

      expect(response).to render_template(:destroy)
    end
  end
end
