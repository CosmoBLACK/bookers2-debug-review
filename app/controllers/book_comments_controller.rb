class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id]) # 本の投稿から”ある投稿”を取り出す。findメソッドでデータベースから取り出して、@bookに入れる。
    @book_comment = current_user.book_comments.new(book_comment_params) # コメントを新規投稿するための空のインスタンスを作る。
    # @book_comment = BookComment.new(book_comment_params)、@book_comment.user_id = current_user.idと同じ意味
    @book_comment.book_id = @book.id # 空のインスタンスのbook_idは、今取り出してる"ある投稿”のidを意味する。
    unless @book_comment.save
      render 'error'
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    book_comment = @book.book_comments.find(params[:id])
    book_comment.destroy
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
