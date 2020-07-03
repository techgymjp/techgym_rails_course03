require 'open-uri'

class Books::LibrariesController < ApplicationController
  before_action :set_book, only: [:index]

  def index
    @libraries = Library.all.order("created_at desc")
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end
end

