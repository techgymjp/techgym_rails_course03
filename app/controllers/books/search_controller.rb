require 'open-uri'

class Books::SearchController < ApplicationController
  def new
    @books = []
    @search_word = params.dig(:q, :keyword)
    if @search_word.present?
      url = URI.encode("https://www.googleapis.com/books/v1/volumes?q=#{params[:q][:keyword]}&maxResults=10&startIndex=0&langRestrict=ja")
      user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36"
      f = OpenURI.open_uri(url, { "User-Agent" => user_agent })
    end
  end

  def create
  end

  private

  def get_book_from_json(item)
    book = {isbn: nil}
    ids = item.dig("volumeInfo", "industryIdentifiers")
    if ids && isbn_13_index = ids.index { |h| h["type"] == "ISBN_13" }
      book[:isbn] = ids[isbn_13_index]["identifier"]
    end
    return nil if book.values.include?(nil)
    book
  end

  def books_params
    params.permit(books: [:is_create, book: [:isbn, :thumbnail_url, :title, :description, :url]])
  end
end
