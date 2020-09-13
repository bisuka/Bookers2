class UsersController < ApplicationController
  # ログインしていない状態でアクセスされた場合は、ログイン画面へリダイレクト
  before_action :authenticate_user!

  # 詳細ページ
  def show
    @user = User.find(params[:id])
    # from作成
    @book = Book.new

    # userに関連づけられたbook全てを参照する。単体ならモデル名、複数ならモデル名にsをつける
    @books = @user.books

  end

  def index
    # current_user ログインユーザーを取得
    @user = current_user
    # user infoでnameが表示されない問題
    # @user = User.newを下に書いてしまうと代入されたidがnewで上書きされてしまう為

    # from作成
    # Book.newと書いてあるのでBookモデルをfrom_forに渡す
    # from_forではPostメソッドでcreateアクションに送信が行われ代入されたモデルのコントローラーアクションに飛ばされる
    @book = Book.new
    # カラム取り出し
    @users = User.all

  end

  # 編集ページ
  def edit
    # params[:id]のuser/id/editのidが入る
    @user = User.find(params[:id])

    if @user != current_user
      redirect_to user_path(current_user)
    end
  end

  # 基本的にviewで利用することが無いので、update内で完結する
  def update
    @user = User.find(params[:id])
    # .updateで更新
    if @user.update(user_params)
      flash[:notice] = 'successfully'
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private
  def user_params
    # 必要なカラムを持ってくる記述
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end