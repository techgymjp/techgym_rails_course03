require 'open-uri'

class Libraries::SearchController < ApplicationController
  def new
    @libraries = []
    @city = params.dig(:q, :city)
    if @city.present?
      url = URI.encode("http://api.calil.jp/library?appkey=#{Rails.application.credentials.calil_app_key}&city=#{@city}&format=json&callback= ")
      user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36"
      f = OpenURI.open_uri(url, { "User-Agent" => user_agent })
      libraries_json = JSON.load(f.read)

      @libraries = libraries_json.map { |item| get_library_from_json(item) }.compact
    end
  end
 
  def create
    render plain: params
  end

  private

  def get_library_from_json(item)
    library = {}
    library[:name] = item.dig("formal")
    library[:code] = item.dig("systemid")
    library[:key] = item.dig("libkey")
    library[:address] = item.dig("address")
    library[:tel] = item.dig("tel")
    library[:url] = item.dig("url_pc")
    return nil if library.values.include?(nil)
    library
  end
end
