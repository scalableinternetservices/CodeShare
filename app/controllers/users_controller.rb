class UsersController < ApplicationController
	def show
	    if user_signed_in?
	      @user = current_user
	      @avatar_url = Dragonfly.app.generate(:initial_avatar, @user.email, {background_color: '00695c', size: '200'}).url
	    else
	      redirect_to login_path
	    end
	end
end
