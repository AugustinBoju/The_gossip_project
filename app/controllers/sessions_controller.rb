class SessionsController < ApplicationController
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
    # cherche s'il existe un utilisateur en base avec l’e-mail
    user = User.find_by(email: params[:email])

    # on vérifie si l'utilisateur existe bien ET si on arrive à l'authentifier (méthode bcrypt) avec le mot de passe
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
    # redirige où tu veux, avec un flash ou pas
      flash.now[:succes] = 'Invalid email/password combination'
      render 'gossips/index'
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'sessions/new'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to :root
  end
end
