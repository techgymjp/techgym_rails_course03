require 'open-uri'

class Books::LibrariesController < ApplicationController
  before_action :set_book, only: [:index]

  def index
    @libraries = Library.all.order("created_at desc")
    libkeys = @libraries.pluck(:code).join(',')
    url = URI.encode("http://api.calil.jp/check?appkey=#{Rails.application.credentials.calil_app_key}&isbn=#{@book.isbn}&systemid=#{libkeys}&format=json&callback=no")
    user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36"
    f = OpenURI.open_uri(url, { "User-Agent" => user_agent })
    check_json = JSON.load(f.read)
    @check_data = check_json["books"][@book.isbn]
    render plain: @check_data
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end
end

