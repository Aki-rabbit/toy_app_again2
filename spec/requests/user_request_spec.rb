# frozen_string_literal: true

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    let!(:alice) { create(:user, name: 'Alice', email: 'alice@example.com') }
    let!(:bob) { create(:user, name: 'Bob', email: 'bob@example.com') }

    context 'ユーザー一覧ページにアクセスした場合' do
      before { get users_path }

      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end

      it 'タイトルが正しく表示されていること' do
        expect(response.body).to include('Users')
      end

      it 'ユーザーの名前が表示されていること' do
        expect(response.body).to include(alice.name)
        expect(response.body).to include(bob.name)
      end
    end
  end

  describe 'GET /users/new' do
    context 'ユーザー新規登録ページにアクセスした場合' do
      before { get new_user_path }

      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end

      it 'タイトルが正しく表示されていること' do
        expect(response.body).to include('New user')
      end

      it 'ユーザー登録フォームが表示されていること' do
        expect(response.body).to include('Name')
        expect(response.body).to include('Email')
        expect(response.body).to include('Create User')
      end
    end
  end

  describe 'POST /users' do
    context '有効なパラメータの場合' do
      let(:valid_params) { { user: { name: 'Charlie', email: 'Charlie@gmail.com' } } }

      it 'ユーザーが新規登録されること' do
        expect do
          post users_path, params: valid_params
        end.to change(User, :count).by(1)
      end

      it 'ユーザー詳細画面にリダイレクトされること' do
        post users_path, params: valid_params
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(user_path(User.last))
        follow_redirect!
        expect(response.body).to include('User was successfully created.')
      end
    end
  end

  describe 'PATCH /users/:id' do
    let!(:user) { create(:user, name: 'David', email: 'David@gmail.com') }

    context '有効なパラメータの場合' do
      it 'ユーザー情報が更新される' do
        patch user_path(user), params: { user: { name: 'David Updated', email: 'DavidUpdated@gmail.com' } }
        expect(user.reload.name).to eq('David Updated')
        expect(user.reload.email).to eq('DavidUpdated@gmail.com')
      end

      it '詳細ページに302でリダイレクトする' do
        patch user_path(user), params: { user: { name: 'David Updated', email: 'DavidUpdated@gmail.com' } }
        expect(response).to redirect_to(user_path(user))
        follow_redirect!
        expect(response.body).to include('User was successfully updated.')
      end
    end
  end

  describe 'DELETE /users/:id' do
    let!(:user) { create(:user, name: 'Eve', email: 'Eve@gmail.com') }

    context 'ユーザー削除を実行した場合' do
      it 'ユーザーが削除され、一覧へ302でリダイレクトする' do
        expect do
          delete user_path(user)
        end.to change(User, :count).by(-1)
        expect(response).to redirect_to(users_path)
        follow_redirect!
        expect(response.body).to include('User was successfully destroyed.')
      end
    end
  end
end
