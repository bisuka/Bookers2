class RelationshipsController < ApplicationController
	def follow
	  # フォローされる側の情報が必要。フォローする側はcurrent.user.idで持って来れる

	  # follower_idにカレントユーザーのidが入る。
	  @user   =  current_user.follow(params[:id])
	  redirect_to users_path
	end

	def follows
	end

	def unfollow
	  current_user.unfollow(params[:id])
	  redirect_to users_path
	end

	def unfollows
		@user = User.find(params[:id])
	end

end
