class MyBookController < ApplicationController

  def index

  end

  def get_books
    @books = Book.all;
    render json: @books;
  end

  def find_book
    @book = Book.find_by_name(params[:name])
    render json: @book;
  end
end
