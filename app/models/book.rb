class Book < ApplicationRecord
# 　ユーザーモデルと関連付け
  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy


  # カレントユーザーのidが、投稿がいいねされているかどうか判断する
  def favorited_by?(user)

    # where() 比べるメソッド
    # user_id:  favoriteのuser_idカラム
    # user_id   current_userのidカラム
    # exists  存在する？

    # favoritesモデルの　user_idカラムにカレントユーザーのidは　存在する？

    # user_id: カラム　user.id 具体的な値
    favorites.where(user_id: user.id).exists?
  end

  # titleとbodyが入っていればtrue
  validates :title, presence: true
  validates :body, presence: true,
                   length: { maximum: 200 }
end
