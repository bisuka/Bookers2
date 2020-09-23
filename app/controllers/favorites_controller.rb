class FavoritesController < ApplicationController

  # いいね作成
  def create

    book = Book.find(params[:book_id])

    # キー参照参照して、newの時にカラムに変わる。
    favorite = current_user.favorites.new({ book_id: book.id })

    # newで段階でbook_idの名前のキーが作成されている。
    favorite = current_user.favorites.new
    favorite.book_id = book.id

    favorite.save

    redirect_to books_path
  end

# 　いいね削除
  def destroy
    book = Book.find(params[:book_id])

    favorite = current_user.favorites.find_by(book_id: book.id)

    favorite.destroy

    redirect_to books_path
  end

end
