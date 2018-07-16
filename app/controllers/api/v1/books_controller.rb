class Api::V1::BooksController < ApplicationController
  def index
    books = Book.all
    render status: 200, json: {
      count: books.count,
      books: books,
      message: "All of the books!"
    }
  end

  def show
    render status: 200, json: Book.find(params[:id])
  end
end