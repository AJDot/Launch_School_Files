require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

get "/" do
  filenames_with_path = Dir.glob("public/*").sort
  @files = filenames_with_path.map do |filename|
    File.basename(filename)
  end

  @files.reverse! if params[:sort] == "desc"

  erb :list
end
