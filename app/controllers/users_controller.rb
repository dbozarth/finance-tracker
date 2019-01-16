class UsersController < ApplicationController

  def my_portfolio
    @user = current_user
    @user_stocks = current_user.stocks
  end

  def my_friends
    @friendships = current_user.friends 
  end

  def search
    @users = User.search(params[:search_param])
    if params[:search_param].blank? 
      flash.now[:danger] = "You have entered an empty search string"
    else 
      @users = User.search(params[:search_param])
      @users = current_user.except_current_users(@users)
      flash.now[:danger] = "No user matches this search criteria or you have search for yourself. Try again please." if @users.blank?
    end
    respond_to do |format|
      format.js { render partial: 'friends/result' }
    end 
  end

  def add_friend
    @friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: @friend.id)
    
    if current_user.save
      flash.now[:success] = "Friend was successfully added"
      redirect_to my_friends_path 
    else
      flash.now[:error] = "There was an error with adding user as friend"
      redirect_to my_friends_path 
    end
  end

  def show
    @user = User.find(params[:id])
    @user_stocks = @user.stocks
  end

end