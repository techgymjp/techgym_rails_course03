require 'open-uri'

class Books::SearchController < ApplicationController
  def new
    @books = []
    @search_word = params.dig(:q, :keyword)
    if @search_word.present?
      url = URI.encode("https://www.googleapis.com/books/v1/volumes?q=#{params[:q][:keyword]}&maxResults=10&startIndex=0&langRestrict=ja")
      f = OpenURI.open_uri(url, { "User-Agent" => Settings.USER_AGENT })
      books_json = JSON.load(f.read)

      @books = books_json["items"].map { |item| get_book_from_json(item) }.compact
    end
  end

  def create
    books_params[:books].values.each do |book_params|
      if book_params[:is_create]
        Book.create(book_params[:book])
      end
    end
    redirect_to books_path, notice: "#{Book.model_name.human}を追加しました"
  end

  private

  def get_book_from_json(item)
    book = {isbn: nil}
    ids = item.dig("volumeInfo", "industryIdentifiers")
    if ids && isbn_13_index = ids.index { |h| h["type"] == "ISBN_13" }
      book[:isbn] = ids[isbn_13_index]["identifier"]
    end
    book[:title] = item.dig("volumeInfo", "title")
    book[:url] = item.dig("volumeInfo", "previewLink")
    book[:description] = item.dig("volumeInfo", "description")
    book[:thumbnail_url] = item.dig("volumeInfo", "imageLinks", "thumbnail")
    return nil if book.values.include?(nil)
    book
  end

  def books_params
    params.permit(books: [:is_create, book: [:isbn, :thumbnail_url, :title, :description, :url]])
  end
end
