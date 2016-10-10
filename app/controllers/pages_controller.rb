class PagesController < ApplicationController
	def index
		if user_signed_in?
			@user = current_user
		else
			redirect_to login_path
		end
	end
end
