require 'open-uri'

class Libraries::SearchController < ApplicationController
  def new
    @libraries = []
    @city = params.dig(:q, :city)
    if @city.present?
      url = URI.encode("http://api.calil.jp/library?appkey=#{Rails.application.credentials.calil_app_key}&city=#{@city}&format=json&callback= ")
      f = OpenURI.open_uri(url, { "User-Agent" => Settings.USER_AGENT })
      libraries_json = JSON.load(f.read)

      @libraries = libraries_json.map { |item| get_library_from_json(item) }.compact
    end
  end
 
  def create
    libraries_params[:libraries].values.each do |library_params|
      if library_params[:is_create]
        Library.create(library_params[:library])
      end
    end
    redirect_to libraries_path, notice: "#{Library.model_name.human}を追加しました"
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

  def libraries_params
    params.permit(libraries: [:is_create, library: [:name, :code, :key, :address, :tel, :url]])
  end
end
