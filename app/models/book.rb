class Book < ApplicationRecord
# 　ユーザーモデルと関連付け
  belongs_to :user

  # titleとbodyが入っていればtrue
  validates :title, presence: true
  validates :body, presence: true,
                   length: { maximum: 200 }
end
