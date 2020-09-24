class User < ApplicationRecord
# 　ログイン機能などが利用できる
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # bookモデルNと関連付け
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  # class_name 一つのモデルに対して、二つのアソシエーション経路を組む
  # フォローする人は「follower」 フォローされる人は「followed」
  # user.followerとすることでフォローした一覧が観れる
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォロワー取得
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人

  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end

  # refileを使えるようにする記述
  attachment :profile_image

  # nameとintroductionが入っていればtrue
  validates :name, presence: true,
  				         length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }
end

# 1:N

# User:Book

# * Nのほうが相手のidを model名_id に持つ必要がある.

# user
# 	id: 1, name: 'kazuki', email ...
# user
# 	id: 2, name: 'naoki', email ...
# user
# 	id: 3, name: 'yayoi'
# user
# 	id: 4, name: 'taro'
# ...

# book
# 	id: 1, title: 'Ruby', body: 'WEB app'
# book
# 	id: 2, title: 'Ruby', body: 'WEB App'
# ...