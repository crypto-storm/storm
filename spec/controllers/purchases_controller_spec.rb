require 'rails_helper'

RSpec.describe PurchasesController, type: :controller do
  let(:portfolio) { create(:portfolio) }
  let(:token) { create(:token) }
  let(:location) { create(:chain) }

  let(:purchase) { create(:transaction, :purchase, portfolio:) }
  let(:purchase_params) do
    build(:transaction, :purchase, token:, location:).tx_in.slice('amount', 'rate', 'location', 'token_id')
  end

  let(:purchase_params_for_form) do
    params = purchase_params.dup
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
    before { get :edit, params: { id: purchase.id } }

    it 'assigns @transaction' do
      expect(assigns[:transaction]).to eq(purchase)
    end

    it 'renders the edit template' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST create' do
    let(:date) { DateTime.now }
    let(:request) { post :create, params: { tx_in: purchase_params_for_form, date: }, format: :turbo_stream }

    before { portfolio }

    it 'assigns @transaction' do
      request

      transaction = Transaction.new(date:, portfolio:)
      transaction.build_tx_in(purchase_params)
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
      put :update, params: { id: purchase.id, tx_in: purchase_params_for_form }, format: :turbo_stream
      purchase.reload
    end

    it 'assigns @transaction' do
      expect(assigns[:transaction]).to eq(purchase)
    end

    it 'updates transaction' do
      expect(purchase.tx_in.amount).to eq(purchase_params['amount'])
    end

    it 'renders the update turbo stream template' do
      expect(response).to render_template(:update)
    end
  end

  # describe 'DELETE destroy' do
  # let(:request) { delete :destroy, params: { id: purchase.id }, format: :turbo_stream }

  # before { purchase }

  # it 'assigns @transaction' do
  # request

  # expect(assigns[:transaction]).to eq(purchase)
  # end

  # it 'deletes transaction' do
  # expect { request }.to change(Transaction, :count).by(-1)
  # end

  # it 'renders the destroy turbo stream template' do
  # request

  # expect(response).to render_template(:destroy)
  # end
  # end
end
