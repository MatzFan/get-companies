require 'sinatra'
require_relative './jersey_scraper'

get '/jersey' do
  JerseyScraper.new(params[:text]).company_data.map { |row| row.join('|') }.join("\n")
end
