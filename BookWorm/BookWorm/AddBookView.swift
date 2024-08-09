import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""

    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry","Romance", "Thriller"]

    var body: some View {
        Form {
            Section {
                TextField("Name of book", text: $title)
                TextField("Author's name", text: $author)
                RatingView(rating: $rating)
            }

            Section("Write a review") {
                TextEditor(text: $review)

                Picker("Rating", selection: $rating) {
                    ForEach(0..<6) {
                        Text(String($0))
                    }
                }
            }
            Section {
                Button("Save") {
                    let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating, date: .now)
                    modelContext.insert(newBook)
                    dismiss()
                }
            }
            .disabled(title.isEmpty || author.isEmpty)

        }
        .navigationTitle("Add book")
    }
}

#Preview {
    AddBookView()
}
