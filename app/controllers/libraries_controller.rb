class LibrariesController < ApplicationController
  before_action :set_library, only:[:show, :destroy]

  def index
    @libraries = Library.all.order("created_at desc")
  end

  def show
  end

  def destroy
    @library.destroy
    redirect_to libraries_path, notice: "#{Library.model_name.human}を削除しました。"
  end

  private

  def set_library
    @library = Library.find(params[:id])
  end
end
