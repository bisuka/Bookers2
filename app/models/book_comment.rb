class BookComment < ApplicationRecord
	belongs_to :user
	belongs_to :book

	# saveの段階で弾かれる
	validates :comment, presence: true
end
