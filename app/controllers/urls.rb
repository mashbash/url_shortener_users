get '/' do
  # let user create new short URL, display a list of shortened URLs
  @urls = Url.all
  erb :index
end

post '/urls' do
  puts "[LOGIN URL] #{params}"
  puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
  # create a new Url
  # see if there is a user signed in
  # if so, pass their id to Url.create
  # otherwise, just create a url
  @usr = User.find_by_profile_url(params[:usr_profile])
  @url = Url.create(:long => params[:long])
  @usr.urls << @url
  puts "@url"
  puts "#{params}"
  puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
  redirect "/user/#{params[:usr_profile]}"
end

# e.g., /q6bda
get '/:short_url' do
  puts params
  url_object = Url.find_by_short(params[:short_url])
  url_object.click_count += 1
  url_object.save

  redirect url_object.long
end


put '/url/:id' do
  #change the url
end


