require 'open-uri'

class Libraries::SearchController < ApplicationController
  def new
    @city = params.dig(:q, :city)
    if @city.present?
      url = URI.encode("http://api.calil.jp/library?appkey=#{Rails.application.credentials.calil_app_key}&city=#{@city}&format=json&callback= ")
      user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36"
      f = OpenURI.open_uri(url, { "User-Agent" => user_agent })
      libraries_json = JSON.load(f.read)

      render plain: libraries_json
    end
  end
 
  def create
    render plain: params
  end
end
