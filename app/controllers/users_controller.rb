class UsersController < ApplicationController
	def show
	    if user_signed_in?
	      @user = current_user

	      # If user set their name, use that for the default avatar. Otherwise default to the email.
	      avatar_name = @user.email
	      if @user.first_name
	      	avatar_name = @user.first_name
	      end
	      if @user.last_name
	      	avatar_name << " " << @user.last_name
      	  end

	      @avatar_url = Dragonfly.app.generate(:initial_avatar, avatar_name, {background_color: '00695c', size: '200'}).url
	    else
	      redirect_to login_path
	    end
	end
end
