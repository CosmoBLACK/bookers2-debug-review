class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id]) # 本の投稿から”ある投稿”を取り出す。findメソッドでデータベースから取り出して、bookというローカル変数に入れる。
    comment = current_user.book_comments.new(book_comment_params) # コメントを新規投稿するための空のインスタンスを作る。
    # comment = BookComment.new(book_comment_params)、comment.user_id = current_user.idと同じ意味
    comment.book_id = book.id # 空のインスタンスのbook_idは、今取り出してる"ある投稿”のidを意味する。
    comment.save
    redirect_to request.referer
  end

  def destroy
    BookComment.find(params[:id]).destroy
    redirect_to request.referer
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
