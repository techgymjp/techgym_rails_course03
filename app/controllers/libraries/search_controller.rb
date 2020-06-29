require 'open-uri'

class Libraries::SearchController < ApplicationController
  def new
  end

  def create
    render plain: params
  end
end
