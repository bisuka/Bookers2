class Book < ApplicationRecord
# 　ユーザーモデルと関連付け
  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  # メソッド名はなんでもいい。今回はfavorited_by?
  # (user)はブロック変数に近い。
  def favorited_by?(user)

    #(○: ●)の記述について   ○: カラム　● 具体的な値
    # user_id:  favoriteのuser_idカラム
    # user.id カレントユーザーのid
    favorites.where(user_id: user.id).exists?
  end

  # titleとbodyが入っていればtrue
  validates :title, presence: true
  validates :body, presence: true,
                   length: { maximum: 200 }
end
