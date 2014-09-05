require 'sinatra'
require_relative './scraper'

get '/' do
  Scraper.new(params[:text]).companies.map { |row| row.join('|') }.join("\n")
end
