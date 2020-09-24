class BookCommentsController < ApplicationController
	def create

		# /books/:book_id/book_comments
	    book = Book.find(params[:book_id])

	    # {comment: nil}
	    comment = current_user.book_comments.new(book_comment_params)
	    # 関連付け
	    comment.book_id = book.id
	    comment.save
	    redirect_to book_path(book)

	end

	def destroy
		book_comment = BookComment.find(params[:id])
		book_comment.destroy

		# BookComment.find(params[:id]).destroy は上の省略形の書き方

		book_id = book_comment.book_id

	    # BookComment.find_by(id: params[:id], comment: params[:comment]).destroy
	    redirect_to book_path(book_id)
	end

	private
	def book_comment_params
	    # 必要なカラムを持ってくる記述
	    params.require(:book_comment).permit(:comment)
	end
end
