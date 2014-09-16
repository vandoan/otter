class UserFriendshipsController < ApplicationController

	before_filter :authenticate_user!, only: [:new]

def new 
    if params[:friend_id]
        @friend = User.where(profile_name: params[:friend_id]).first
        raise ActiveRecord::RecordNotFound if @friend.nil?
        @user_friendship = current_user.user_friendships.new(friend: @friend)
    else
        flash[:error] = "Friend required"
    end
rescue ActiveRecord::RecordNotFound
    render file: 'public/404', status: :not_found
end
	
  def accept
    @user_friendship = current_user.user_friendships.find(params[:id])
    if @user_friendship.accept!
      flash[:success] = "You are now friends with #{@user_friendship.friend.first_name}"
    else
      flash[:error] = "That friendship could not be accepted"
    end
    redirect_to user_friendships_path
  end

	def index 

		@user_friendships = current_user.user_friendships.all

	end 

	def edit
		@user_friendship * current_user.user_friendships.find(param[:id])
		@friend = @user_friendship.friend
	end 


	def destroy
		@user_friendship = current_user.user_friendships.find(params[:id])
		if @user_friendship.destroy
			flash[:success] = "Friendship destoyed", flash[:success]
		end
	end 


	def create
	#	if params[:friend_id]
		#	@friend = User.where(profile_name: params[:friend_id]).first
	 	if params[:user_friendship] && params[:user_friendship].has_key?(:friend_id)
	 		@friend = User.where(profile_name: params[:user_friendship][:friend_id]).first
	 		@user_friendship = UserFriendship.request(current_user, @friend)
	 		# signals the request
			respond_to do |format|	 		
		 		@user_friendship.save
		 		flash[:success] = "You are now friends with #{@friend.first_name}"
		 		redirect_to profile_path(@friend)
			 	if @user_friendship = UserFriendship.request(current_user, @friend)
			 		format.html do 
			 			flash[:error] = "There was a problem creating that friend request."
			 			redirect_to profile_path(@friend)
			 		end 
			 	else 
			 		format.html do 
			 			flash[:success] = "Firend request sent."
			 			redirect_to profile_path(@friend)
			 		end 
			 		format.json { render json: @user_friendship.to_json } 
			 	end 
			 end 
		else
			flash[:error] = "Friend required" 
			redirect_to root_path 
		end 
	end 

 def user_params
      params.require(:user).permit(:friend, :user_id, :friend_id, :state, :email)
    end



end
