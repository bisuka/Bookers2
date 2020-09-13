class BooksController < ApplicationController
    # ログインしていない状態でアクセスされた場合は、ログイン画面へリダイレクト
    # , except: [:top] top画面は除く
    before_action :authenticate_user!, except: [:top,:about]

    def top
    end

    # Books 本一覧
    def index
        @user = current_user

        @users = User.all

        # from作成
        @book = Book.new
        # カラム取り出し
        @books = Book.all
    end

    # Books 本詳細ページ
    def show
        # from作成
        @book = Book.new
        @books = Book.all

        #パラメーターが38なら <Book id: 38, title: "aaaaa", body: "aaaaa", user_id: 7, を全て取得
        @book_id = Book.find(params[:id])
        #<Book id: 38, title: "aaaaa", body: "aaaaa", user_id: 7 ここから.モデル名とすることで
        #１：Nの１のテーブル全てを取り出せる。
        # #<User id: 7, email: "a@p", introduction: "aaa", profile_image_id: nil, created_at: "2020-09-09 22:50:21", updated_at: "2020-09-11 20:26:38", name: "aaa">
        @user = @book_id.user
    end

    # Books 本編集ページ
    def edit
        # params[:id]のuser/id/editのidが入る
        #              ↓
        # @book = Book.find(38)  Book id:38だけではなくbookモデルの情報全て取得
        #<Book id: 38, title: "aaaaa", body: "aaaaa", user_id: 7,
        @book = Book.find(params[:id])

        # 本の投稿者と、ログイン中のユーザーが一致しなければ本一覧へ遷移
        # 最初は@book.user_id == current_user.idでtrueならrediret_to book_edit_pathと書いていたがそれだとedit → edit → edit のようにループになる
        if @book.user_id != current_user.id
            redirect_to books_path
        end
    end

    # 本編集反映
    def update
        @book = Book.find(params[:id])
        # .updateで更新
        if @book.update(book_params)
            flash[:notice] = 'You have creatad book successfully.'
            redirect_to book_path(@book)
        else
            render :edit
        end
    end

    # New Book投稿
    def create
        @book = Book.new(book_params)

        # current_user.idはログイン中のユーザーID
        # .user_idはschema.rbのuser_idカラム
        # user_idはどのユーザーが投稿したかを判別するためにある

        # 本からしたらどのユーザーが投稿したのかが分からない。1:Nに対しこの時はN:1のようなもの
        # そこでこの投稿のuser_idは今ログイン中のユーザーですよと教えている
        @book.user_id = current_user.id

        # render利用のため記述
        @books = Book.all

        if @book.save
            flash[:notice] = 'You have creatad book successfully.'
            redirect_to book_path(@book)
        else
            # コントローラーのindexアクションには飛ばずにbooks#indexに遷移
            # その為上記で@booksの記述を書かないと本の一覧が表示できない
            render :index
        end
    end

    # 本削除
    def destroy
        book = Book.find(params[:id])
        book.destroy
        redirect_to books_path
    end

    private
    def book_params
        # 必要なカラムを持ってくる記述
        params.require(:book).permit(:title, :body)
    end
end