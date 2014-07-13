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

  def create
    book = upload_params
    book[:name]=params[:book][:name]
    book[:author]=params[:book][:author]
    book[:category]=params[:book][:category]
    book[:language]=params[:book][:language]
    book[:description]=params[:book][:description]

    @book = Book.create(book)

    redirect_to '/my_book'
  end

  def new
    @book = Book.new
  end

  def upload_params
    params[:book].permit(:cover, :file)
  end

  def upload_params2
    #arams[:book].permit(:file)
  end

end
