require 'open-uri'

class Books::LibrariesController < ApplicationController
  def index
    @libraries = Library.all.order("created_at desc")
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end
end

