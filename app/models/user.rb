class User < ApplicationRecord
# 　ログイン機能などが利用できる
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # bookモデルNと関連付け
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

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