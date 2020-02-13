class UsersController < ApplicationController
  def new
    if current_user
      redirect_to '/'
    end
    @user = User.new
  end

  def create
    if current_user
      redirect_to '/'
    end
    @city = City.find_by(name: params[:city])

    if @city == nil
      @city = City.create(name: params[:city])
    end

    @user = User.new(first_name: params[:firstName], last_name: params[:lastName], email: params[:email], password: params[:password], password_confirmation: params[:passwordConfirmation], age: params[:age], description: params[:description], city_id: @city.id)

    if @user.save
      render 'gossips/index'
    else
      render :new
    end
  end

  def show
    @current_user = User.find(params[:id])
  end
end
