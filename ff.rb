require 'rubygems'
require 'sinatra'
require 'haml'
require 'open-uri'
require 'json'
require 'hpricot'

set :haml, {:format => :html5 }

get '/' do
  haml :index
end

get '/new-image' do
  doc = open("http://fukung.net/random") { |f| Hpricot(f) }  
  a = Hash.new
  a["url"] = doc.at("//img.fukung").attributes['src']
  tags = Array.new
  doc.search("//span#taglist a").each do |t|
    tags.push(t.inner_text.gsub(/ /,''))
  end
  a["tags"] = tags
  a.to_json
end