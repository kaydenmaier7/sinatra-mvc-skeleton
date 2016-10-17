get '/sessions/new' do
  erb :'sessions/new'
end


post '/sessions' do
  @user = User.authenticate(params[:email], params[:password])

  if @user
    login(@user)
    redirect '/'
  else
    @errors = "User details didn't match anything on record"
    erb :'sessions/new'
  end
end



# delete '/sessions/:id' do
delete '/sessions' do
  # session[:id] = nil
  logout
  redirect '/'
end
