class API::SessionsController < ApplicationController
  def create
    email = credential_params[:email]
    password = credential_params[:password]
    user = email.present? && User.find_by(email: email)

    if user.valid_password? password
      sign_in user, store: false
      user.generate_authentication_token!
      user.save
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: "Invalid email or password" }, status: 422
    end
  end
  def credential_params
    params.require(:session).permit(:email, :password)
  end
end
