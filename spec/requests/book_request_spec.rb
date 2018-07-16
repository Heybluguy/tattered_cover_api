require 'rails_helper'

RSpec.describe "Book API" do
  it "returns all books" do
    Book.create(title: "Harry Potter", author: "J.K. Rowling")
    Book.create(title: "Winnie the Pooh", author: "Christopher Robin")

    get "/api/v1/books"

    content = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(content["count"]).to eq(Book.count)
    expect(content["books"].count).to eq(Book.count)
    expect(content["books"].first["title"]).to eq("Harry Potter")
    expect(content["books"].first["author"]).to eq("J.K. Rowling")
  end

  it "returns a book" do
    Book.create(title: "Harry Potter", author: "J.K. Rowling")
    Book.create(title: "Peter Pan", author: "James Mathew Barrie")

    get "/api/v1/books/2"
    content = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(content["title"]).to eq("Peter Pan")
    expect(content["author"]).to eq("James Mathew Barrie")
  end

  it "creates a new book" do
    Book.create(title: "Harry Potter", author: "J.K. Rowling")
    expect(Book.count).to eq(1)

    post "/api/v1/books", params: { book: {title: "Peter Pan", author: "James Mathew Barrie"} }

    content = JSON.parse(response.body)

    expect(Book.count).to eq(2)
    expect(content["message"]).to eq("Successfully created Peter Pan by James Mathew Barrie.")
    expect(response.status).to eq(201)
  end

end
