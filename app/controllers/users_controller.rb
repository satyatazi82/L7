class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def index
    render plain: User.to_displayable_list.join("\n")
  end

  def show
    id = params[:id]
    render plain: User.find(id).to_displayable_string
  end

  def new
    render "new"
  end

  def create
    first = params[:firstname]
    last = params[:lastname]
    email = params[:email]
    password = params[:password]

    newUser = User.register({:firstname => first, :lastname => last, :email => email, :password => password})
    if !newUser.save
      flash[:error] = newUser.errors.full_messages.join(', ')
      redirect_to new_user_path
    else
      session[:current_user_id] = newUser.id
      redirect_to "/"
    end
  end

  def login

    if (request.post?)
      email = params[:email]
      password = params[:password]
      user = User.find_by(email: email)

      if (user && user.authenticate(password))
        redirect_to todos_path
      elsif
        render plain:"invalid password"
      end

    else

      render "login"

    end
  end
end
