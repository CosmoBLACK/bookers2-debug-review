class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range] # 検索フォームから検索モデル（params[:range]）の情報を受け取る
    # 検索方法（params[:search]）と、検索ワード（params[:word]）を参照してデータを検索
    if @range == "User"
      @users = User.looks(params[:search], params[:word]) # @usersにUserモデル内での検索結果を代入
    else
      @books = Book.looks(params[:search], params[:word]) # @booksにBookモデル内での検索結果を代入
    end
  end
end
