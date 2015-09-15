class EpicenterController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show_user, :now_following, :unfollow]
  def feed
    @following_tweets = []
    @users = User.all


    @users.each do |user|
      if current_user.following.include?(user.id)
        @following_tweets.push(user.tweets)
      end
    end
    @following_tweets.push(current_user.tweets)
    @following_tweets = @following_tweets.flatten.sort_by { |tweet| tweet.created_at }.reverse
    @tweet = Tweet.new
  end

  def show_user
  end
  def followers

    @users = User.all
    @followers = []

    @users.each do |user|
      if user.following.include?(current_user.id)
        @followers.push(user)
      end
    end
  end
  def my_following
    @followed_users = []
    current_user.following.each do |followed_user|
      @followed_users.push(User.find(followed_user))
    end
  end

  def now_following
    current_user.following.push(@user.id)
    current_user.save
  end

  def unfollow

    current_user.following.delete(@user.id)


    current_user.save
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
