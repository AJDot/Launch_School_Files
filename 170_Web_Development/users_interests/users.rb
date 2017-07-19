require "yaml"

require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

before do
  @users = YAML.load_file "users.yaml"
end

helpers do
  def count_interests(users)
    users.reduce(0) do |sum, (name, user)|
      sum + user[:interests].size
    end
  end
end

get "/" do
  redirect "/list"
end

get "/list" do
  @title = "Users"
  erb :list
end

get "/users/:name" do
  # @name = params[:name].to_sym
  @name = params["name"].to_sym

  @title = @name.to_s
  @email = @users[@name][:email]
  @interests = @users[@name][:interests]

  erb :user
end
