get '/' do
  # let user create new short URL, display a list of shortened URLs
  @urls = Url.all
  erb :index
end

post '/urls' do
  # create a new Url
  # see if there is a user signed in
  # if so, pass their id to Url.create
  # otherwise, just create a url
  @url = Url.create(:long => params[:url])
  redirect '/'
end

# e.g., /q6bda
get '/:short_url' do
  url_object = Url.find_by_short(params[:short_url])

  url_object.click_count += 1
  url_object.save

  redirect url_object.long
end
