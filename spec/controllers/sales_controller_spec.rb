require 'rails_helper'

RSpec.describe SalesController, type: :controller do
  let(:portfolio) { create(:portfolio) }
  let(:token) { create(:token) }
  let(:location) { create(:chain) }

  let(:sale) { create(:transaction, :sale, portfolio:, token:) }
  let(:sale_params) do
    build(:transaction, :sale, token:, location:).tx_out.slice('amount', 'rate', 'location', 'token_id')
  end

  let(:sale_params_for_form) do
    params = sale_params.dup
    params['location'] = params['location'].id_with_type
    params
  end

  before { create(:transaction, :purchase, portfolio:, token:, amount: 10_000) }

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
    before { get :edit, params: { id: sale.id } }

    it 'assigns @transaction' do
      expect(assigns[:transaction]).to eq(sale)
    end

    it 'renders the edit template' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST create' do
    let(:date) { DateTime.now }
    let(:request) { post :create, params: { tx_out: sale_params_for_form, date: }, format: :turbo_stream }

    before { portfolio }

    it 'assigns @transaction' do
      request

      transaction = Transaction.new(date:, portfolio:)
      transaction.build_tx_out(sale_params)
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
      put :update, params: { id: sale.id, tx_out: sale_params_for_form }, format: :turbo_stream
      sale.reload
    end

    it 'assigns @transaction' do
      expect(assigns[:transaction]).to eq(sale)
    end

    it 'updates transaction' do
      expect(sale.tx_out.amount).to eq(-sale_params['amount'])
    end

    it 'renders the update turbo stream template' do
      expect(response).to render_template(:update)
    end
  end
end
