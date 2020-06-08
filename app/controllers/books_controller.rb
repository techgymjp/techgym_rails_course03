class BooksController < ApplicationController
  before_action :set_book, only:[:show, :destroy]

  def index
    @books = Book.all.order("created_at desc")
  end

  def show
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: "#{Book.model_name.human}を削除しました。"
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end
end
