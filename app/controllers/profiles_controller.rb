class ProfilesController < ApplicationController
  def show
  	@user = User.find_by_profile_name(params[:id])
  	if @user
      @statuses = @user.statuses.order("created_at DESC").all
  		#{should be @statuses = @user.statuses.all, but broken, scoping issue }
      # (created at DESC puts the earliest post first)
  		render action: :show 
  	else 
  		render file: 'public/404', status: 404, formats: [:html]
  	end 
  end
end
