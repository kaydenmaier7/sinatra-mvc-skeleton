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
      traitify = User.traitify_access.create_assessment(deck_id: 'persuasion')
      Assessment.create(user_id: @user.id, name: 'Persuasion', key: traitify.id)
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
  if request.xhr? && !@user.assessments.find_by(name: 'Persuasion').completed
    assessment_id = @user.assessments.find_by(name: 'Persuasion').id
    Assessment.update(assessment_id, completed: true)
    "Assessment finished. Good luck."
  elsif request.xhr?
    "Assessment finished! Good luck."
  else
    erb :'users/show'
  end
end
