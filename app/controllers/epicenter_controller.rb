class EpicenterController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show_user, :now_following, :unfollow]
  def feed
    @following_tweets = []

    @tweets = Tweet.all

    @tweets.each do |tweet|
      current_user.following.each do |f|
        if tweet.user_id == f
          @following_tweets.push(tweet)
        end
      end
    end
  end

  def show_user
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
