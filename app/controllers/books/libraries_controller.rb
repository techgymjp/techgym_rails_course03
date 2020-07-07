require 'open-uri'

class Books::LibrariesController < ApplicationController
  before_action :set_book, only: [:index]

  def index
    @libraries = Library.all.order("created_at desc")
    libkeys = @libraries.pluck(:code).join(',')
    url = URI.encode("http://api.calil.jp/check?appkey=#{Rails.application.credentials.calil_app_key}&isbn=#{@book.isbn}&systemid=#{libkeys}&format=json&callback=no")
    f = OpenURI.open_uri(url, { "User-Agent" => Settings.USER_AGENT })
    check_json = JSON.load(f.read)
    @check_data = check_json["books"][@book.isbn]
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end
end

