class SubscriptionsController < ApplicationController
  def create
    @user = User.find(params[:id])
    current_user.subscriber_subscriptions.create(subscribed: @user)
    redirect_to request.referrer
  end

  def destroy
    @user = User.find(params[:id])
    current_user.subscriber_subscriptions.find_by(subscribed: @user).destroy
    redirect_to request.referrer
  end
end
