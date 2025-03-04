# Blog Project 🚀

## 👋 はじめに

このプロジェクトは、バックエンドに **Ruby on Rails** を、フロントエンドに **Vue.js** と **Tailwind CSS** を使用して開発されたブログウェブアプリケーションです。ユーザーは記事の作成、編集、削除、カテゴリやタグでのフィルタリング、検索が可能です。また、簡単なユーザー認証機能を提供し、モバイル環境でも最適化されたデザインを体験できます。

## 🛠️ 技術スタック

*   **バックエンド:** Ruby (Ruby on Rails)
    *   Rubyバージョン: (3.0.4)
*   **フロントエンド:** Vue.js (Vite), Tailwind CSS
    *   パッケージマネージャー: npm
*   **データベース:** SQLite3

## ✨ 主な機能

### 📝 ブログ記事管理

*   記事の投稿、編集、削除機能 (Rails)
*   記事のカテゴリおよびタグ連携 (Rails)

### 🔍 検索およびフィルタリング

*   Vue.js を利用したカテゴリ別フィルタリングおよび検索機能

### 🔑 ユーザー認証

*   Rails ベースの簡単なログイン/ログアウト機能

### 📱 レスポンシブデザイン

*   Tailwind CSS のメディアクエリを利用したモバイル対応デザイン

### ➕ 今後追加する項目

*   **ユニットテスト (RSpec):**
    *   Userモデルの有効性検証テスト
    *   PostsControllerのアクションテスト
    *   `api/users/sign_in` APIエンドポイントのテスト
*   **デプロイ手順のドキュメント化:** 

## ⚙️ 特記事項

*   フロントエンド開発に Vite を使用
*   バックエンド API エンドポイントとフロントエンド開発サーバー間の CORS 問題を解決

## 🚀 プログラムセットアップ手順

### 1. 📦 プロジェクトのクローン

```bash
git clone https://github.com/song55555/Blog.git
cd Blog
```

### 2. ⚙️ バックエンドの依存関係インストールおよび環境設定

```bash
gem install bundler
bundle install
rails db:create
rails db:migrate
rails db:seed
```
⚠️ 参考: rails db:seed コマンドはデータベースにサンプルデータを追加します。

### 3. 🚄 バックエンドサーバーの起動

```bash
bundle exec rails s
```
バックエンドサーバーはデフォルトで http://localhost:3000 アドレスで実行されます。

### 4. ⚛️ フロントエンドの依存関係インストールおよびサーバー起動

```bash
cd frontend
npm install
npm run dev
```
フロントエンド開発サーバーはデフォルトで http://localhost:5173 アドレスで実行されます。

### 5. ✅ アプリケーションの確認

ウェブブラウザで http://localhost:5173 アドレスにアクセスしてアプリケーションを確認します。
