Rails.application.routes.draw do
  get 'searches/search'
  get 'relationships/create'
  get 'relationships/destroy'
  get 'book_comments/create'
  get 'book_comments/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: "homes#top"
  get "home/about" => "homes#about"
  get "search" => "searches#search" # 検索ボタンが押された時、Searchesコントローラーのsearchアクションが実行される

  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
    resources :book_comments, only:[:create, :destroy]
    resource :favorites, only: [:create, :destroy] # showページが不要で、idの受け渡しも必要ないのでresourceを使う。ネストすることで、どの投稿(book_id)にいいねを付けたかが特定できる。
  end

  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end