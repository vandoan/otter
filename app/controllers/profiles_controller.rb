class ProfilesController < ApplicationController
  def show
  	@user = User.find_by_profile_name(params[:id])
  	if @user
  		@status = Status.all
  		#{should be @statuses = @user.statuses.all, but broken }


  		render action: :show 
  	else 
  		render file: 'public/404', status: 404, formats: [:html]
  	end 
  end
end
