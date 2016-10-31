
# # USERS INDEX {Display all Users}
# get '/users' do
#   @users = User.all
#   erb :'users/index'
# end


# USERS NEW {Generate Sign Up Page}
get '/users/new' do
  @user = User.new #Creates the User only in Ruby Memory
  erb :'users/new' #Render the view users/new
end

# USERS CREATE {Submit Sign Up Page}
post '/users' do

  if params[:password_confirmation] == params[:user][:password]
    @user = User.new(params[:user])

    if @user.save
      # SUCCESS
      session[:id] = @user.id
      redirect "/users/#{@user.id}"
    else
      # FAILURE
      @errors = @user.errors.full_messages
      erb :'users/new'
    end

  else
    @errors = ["Passwords do not match!"]
    erb :'users/new'
  end
end

# USERS SHOW
get '/users/:id' do
  @user = User.find(params[:id])
  erb :'users/show'
end

# # USERS EDIT
# get '/users/:id/edit' do
#   @user = User.find(params[:id])
#   erb :'users/edit'
# end


# # USERS UPDATE
# put '/users/:id' do
#   @user = User.find(params[:id])
#   @user.update(params[:user])
#   redirect "/users/#{@user.id}"
# end


# # USERS DESTROY
# delete '/users/:id' do
#   @user = User.find(params[:id])
#   @user.destroy
#   redirect "/users"
# end
