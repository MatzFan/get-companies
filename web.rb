require 'sinatra'
require_relative './scraper'

get '/' do
  Scraper.new(params[:text]).company_data.map { |row| row.join('|') }.join("\n")
end
