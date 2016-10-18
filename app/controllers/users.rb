# USERS NEW
get '/users/new' do
  @user = User.new
  erb :'users/new'
end

# USERS CREATE
post '/users' do

  if params[:password_confirmation] == params[:user][:password]
    @user = User.new(params[:user])

    if @user.save
      session[:id] = @user.id
      redirect "/users/#{@user.id}"
    else
      @errors = "Something went wrong. Please try again."
      erb :'users/new'
    end

  else
    @errors = "Passwords do not match!"
    erb :'users/new'
  end

end

# USERS SHOW
get '/users/:id' do
  @user = User.find(params[:id])
  if request.xhr?
    "You have finished this assessment. You will be redirected."
  else
    erb :'users/show'
  end
end
