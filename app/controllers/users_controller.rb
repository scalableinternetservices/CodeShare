class UsersController < ApplicationController
	def feed
		if user_signed_in?
			@user = current_user
		else
			redirect_to login_path
		end
	end
end
