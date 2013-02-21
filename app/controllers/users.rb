require 'digest/md5'

enable :sessions
get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/login' do
  usr = User.find_by_email params[:email]
  # if usr is nil here, that means the account doesn't
  # exist -- print error message and encourage user to register?

  if usr.password == params[:password]
    session[:profile_url] = usr.profile_url
    session[:message] = "Login Successful"
    redirect "/user/#{usr.profile_url}"
  else
    session[:message] = "Login failed"
    redirect '/'
  end
end

get '/logout' do
  # clean out sessions hash
  session.delete("profile_url")
  session[:message] = "Logout complete"
  redirect '/'
end

get '/user/:profile_url' do
  @usr = User.find_by_profile_url(params[:profile_url])
  if @usr.profile_url == session[:profile_url]
    erb :profile
  else
    session[:message] = "Unauthorized access!!!! Please Sign in."
    session.delete("profile_url")
    redirect '/'  
  end  
end

post '/user' do
  profile_url = Digest::MD5.hexdigest("#{params[:email]}#{Time.now}")
  usr = User.new(first_name: params[:first_name],
                 last_name: params[:last_name],
                 email: params[:email],
                 password: params[:password],
                 profile_url: profile_url)
  if usr.save
    session[:message] = "Account successfully created."
    redirect "/user/#{usr.profile_url}"
  else
    # error message
    session[:message] = "Incomplete fields"
  end
end
