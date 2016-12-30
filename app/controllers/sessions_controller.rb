#LOG IN {Generate Page}
get '/sessions/new' do
  erb :'sessions/new'
end

#LOG IN {Submit Page}
post '/sessions' do
  @user = User.find_by_email(params[:email])

  if @user && @user.password == params[:password]
    # session[:id] = @user.id
    login(@user)
    redirect '/'

  else
    @errors = ["Username && Password not found."]
    erb :'sessions/new'
  end
end


# LOG OUT
# delete '/sessions/:id' do
delete '/sessions' do
  # session[:id] = nil
  logout
  redirect '/'
end
