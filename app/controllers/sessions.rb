get '/sessions/new' do
  erb :'sessions/new'
end


post '/sessions' do
  @user = User.authenticate(params[:email], params[:password])
  if !@user
    @user = User.authenticate_by_username(params[:username], params[:password])
  end

  if @user && @user.id == 20
    login(@user)
    redirect '/admin/new'
  elsif @user && @user.assessments.find_by(name: 'Persuasion').completed
    login(@user)
    redirect '/users/' + @user.id.to_s
  elsif @user
    login(@user)
    redirect '/'
  else
    @errors = login_errors(params)
    erb :'sessions/new'
  end
end



# delete '/sessions/:id' do
delete '/sessions' do
  # session[:id] = nil
  logout
  redirect '/'
end
