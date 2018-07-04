require 'rails_helper'

RSpec.describe "Book API" do
  it "returns all books" do
    Book.create(title: "Harry Potter", author: "J.K. Rowling")
    Book.create(title: "Winnie the Pooh", author: "Christopher Robin")

    get "/api/v1/books"

    content = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(content["count"]).to eq(Book.count)
  end

end
