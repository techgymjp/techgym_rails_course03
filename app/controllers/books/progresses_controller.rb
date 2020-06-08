class Books::ProgressesController < ApplicationController
  before_action :set_book, only: [:update]

  def update
    if @book.update(progress_params)
      redirect_to books_path, notice: "#{Book.model_name.human}を更新しました。"
    else
      redirect_to books_path, notice: "#{Book.model_name.human}の更新に失敗しました。"
    end
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def progress_params
    params.fetch(:book, {}).permit(:status)
  end
end
