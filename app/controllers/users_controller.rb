class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render plain: User.to_displayable_list.join("\n")
  end

  def show
    id = params[:id]
    render plain: User.find(id).to_displayable_string
  end

  def create
    name = params[:name]
    email = params[:email]
    password = params[:password]

    newUser = User.register({:name => name, :email => email, :password => password})
    render plain: "Hey, New User is created with the id #{newUser.id}"
  end

  def login
    email = params[:email]
    password = params[:password]
    user = User.login(email, password)

    render plain: user ? true : false
  end
end
