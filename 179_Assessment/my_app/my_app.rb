require 'sinatra'
require 'sinatra/reloader' if development?

helpers do
  def deslugify(string)
    string.split('-').map(&:capitalize).join(' ')
  end

  def slugify(string)
    string.downcase.gsub(" ", "-")
  end

  def in_links(array)
    array.map do |item|
      "<a href=/recipes/#{slugify(item)}>" +
      item +
      "</a>"
    end
  end
end

get '/' do
  redirect '/index'
end

get '/index' do
  @recipes = ['Banana Bread', 'Banana Muffins', 'Banana Pizza']
  erb :index, layout: :layout
end

get '/recipes/:name' do
  @recipe = deslugify(params[:name])
  erb :recipe
end
