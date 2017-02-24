class UsersController < ApplicationController
  # before_action :check_status, :except => [:login, :register, :auth, :create]

  def index
    render '/users/index'
  end

  def register
    render '/users/register'
  end

  def create_user
    user = User.create(name: params[:name], alias: params[:alias], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])

    if user.valid?
      session[:user_id] = user.id
      flash[:success] = "You have successfully signed up!"
      redirect_to "/ideas"
    else
      flash[:errors] = user.errors.full_messages
      redirect_to '/register'
    end
  end

  def login
    user = User.find_by_email(params[:email])
    # print @user.name, "<<<<<<<<<<<<<<<S"
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in!"
      # print session[:user_id], " <========= SESSION"
      # render json: user
      redirect_to '/ideas'
    else
      flash[:errors] = "Your login credentials are incorrect!"
      # user.errors.full_messages
      print flash[:errors], '<<<<<<<<<<<<<<<<<<'
      redirect_to '/'
    end
  end

  def ideas
    @id = session[:user_id]
    @user = User.find(@id)
    @ideas = Idea.all
    @user_ideas = User.find(@id).ideas
    @user_likes = Like.where(user: User.find(@id))
    # render json: @user_likes[0]
    render '/users/ideas'
  end

  def profile
    @id = session[:user_id]
    @user = User.find(@id)
    @user_ideas_total = Idea.where(user: User.find(@id))
    @user_likes_total = Like.where(user: User.find(@id))
    render "/users/profile"
  end

  def create_idea
    @id = session[:user_id]
    @new_idea = Idea.create(idea: params[:idea], user: User.find(@id))
    flash[:success] = "New idea successfully posted!"
    redirect_to "/ideas"
  end

  def delete_idea
    @id = session[:user_id]
    Idea.find(params[:id]).destroy
    redirect_to "/ideas"
  end

  def like_idea
    like = Like.where(user: User.find(session[:user_id]), idea: Idea.find(params[:id]))
    if like.empty?
      Like.create(user: User.find(session[:user_id]), idea: Idea.find(params[:id]))
      flash[:success] = "Idea liked!"
      redirect_to '/ideas'
    else
      flash[:notice] = "You can't like an idea twice, bro!"
      redirect_to '/ideas'
    end
  end

  def unlike_idea
    unlike = Like.where(user: User.find(session[:user_id]), idea: Idea.find(params[:id])).destroy_all
    redirect_to '/ideas'
  end







  def logout
    reset_session
    flash[:success] = "You have successfully logged out!"
    redirect_to '/'
  end

  private
  # def check_status
  #   if !session[:user_id]
  #     redirect_to '/'
  # end
end
