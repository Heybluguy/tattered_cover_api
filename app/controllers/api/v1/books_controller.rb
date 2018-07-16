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

  def create
    book = Book.new(book_params)
    if book.save
      render status: 201, json: {
        message: "Successfully created #{book.title} by #{book.author}."
      }
    else
      render status: 400, json: {
        message: "Create unsuccessful."
      }
    end
  end

    private
      def book_params
        params.require(:book).permit(:title, :author)
      end
end