# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Microposts', type: :request do
  describe 'GET /microposts' do
    let!(:user) { create(:user, name: 'Alice', email: 'alice@example.com') }
    let!(:first_micropost) { create(:micropost, content: 'First post', user_id: user.id) }
    let!(:second_micropost) { create(:micropost, content: 'Second post', user_id: user.id) }

    context 'マイクロポスト一覧ページにアクセスした場合' do
      before { get microposts_path }

      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end

      it 'タイトルが正しく表示されていること' do
        expect(response.body).to include('Microposts')
      end

      it 'マイクロポストの内容が表示されていること' do
        expect(response.body).to include(first_micropost.content)
        expect(response.body).to include(second_micropost.content)
      end
    end
  end

  describe 'GET /microposts/new' do
    context 'マイクロポスト新規登録ページにアクセスした場合' do
      before { get new_micropost_path }

      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end

      it 'タイトルが正しく表示されていること' do
        expect(response.body).to include('New micropost')
      end

      it 'マイクロポスト登録フォームが表示されていること' do
        expect(response.body).to include('Content')
        expect(response.body).to include('User')
        expect(response.body).to include('Create Micropost')
      end
    end
  end

  describe 'POST /microposts' do
    let!(:user) { create(:user, name: 'Bob', email: 'bob@example.com') }

    context '有効なパラメータの場合' do
      let(:valid_params) { { micropost: { content: 'Test content', user_id: user.id } } }

      it 'マイクロポストが新規登録されること' do
        expect do
          post microposts_path, params: valid_params
        end.to change(Micropost, :count).by(1)
      end

      it 'マイクロポスト詳細画面にリダイレクトされること' do
        post microposts_path, params: valid_params
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(micropost_path(Micropost.last))
        follow_redirect!
        expect(response.body).to include('Micropost was successfully created.')
      end
    end
  end

  describe 'PATCH /microposts/:id' do
    let!(:user) { create(:user, name: 'Charlie', email: 'charlie@example.com') }
    let!(:micropost) { create(:micropost, content: 'Original content', user_id: user.id) }

    context '有効なパラメータの場合' do
      it 'マイクロポスト情報が更新され、詳細へ302でリダイレクトする' do
        patch micropost_path(micropost), params: { micropost: { content: 'Updated content', user_id: user.id } }
        expect(response).to redirect_to(micropost_path(micropost))
        follow_redirect!
        expect(response.body).to include('Micropost was successfully updated.')
        expect(micropost.reload.content).to eq('Updated content')
      end
    end

    context '無効なパラメータの場合' do
      it 'マイクロポスト情報が更新されず、編集画面へ422でレンダリングする' do
        patch micropost_path(micropost), params: { micropost: { content: '', user_id: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(micropost.reload.content).to eq('Original content')
      end
    end
  end

  describe 'DELETE /microposts/:id' do
    let!(:user) { create(:user, name: 'David', email: 'david@example.com') }
    let!(:micropost) { create(:micropost, content: 'To be deleted', user_id: user.id) }

    context 'マイクロポスト削除を実行した場合' do
      it 'マイクロポストが削除され、一覧へ302でリダイレクトする' do
        expect do
          delete micropost_path(micropost)
        end.to change(Micropost, :count).by(-1)
        expect(response).to redirect_to(microposts_path)
        follow_redirect!
        expect(response.body).to include('Micropost was successfully destroyed.')
      end
    end
  end
end
