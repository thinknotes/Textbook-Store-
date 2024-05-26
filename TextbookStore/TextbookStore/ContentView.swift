//
//  ContentView.swift
//  TextbookStore
//
//  Created by Avi Bansal on 5/19/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
//    @Query private var items: [Item]
    
    @State var search: String = ""
    
    let allSubjets = [
        
        Token(title: "Math"),
        Token(title: "Science"),
        Token(title: "English"),
        Token(title: "Art - Humanity"),
        Token(title: "History"),
        Token(title: "Other")
    
    ]
    
    let books = [
        Book(title: "Prinplces of enginer", subject: "Math", authors: ["Sam GoodsBugr"], pdf: "", image: Image(systemName: "book.pages.fill")),
        Book(title: "History of the world", subject: "History", authors: ["Leonard Lee"], pdf: "", image: Image(systemName: "book.pages.fill")),
        Book(title: "Spainsh 101", subject: "Other", authors: ["Maria Gonzulezs"], pdf: "", image: Image(systemName: "book.pages.fill"))
    
    ]
    
    @State private var currentTokens = [Token]()
    
    var suggestedTokens: [Token] {
            if search.starts(with: "#") {
                return allSubjets
            } else {
                return []
            }
        }
    
    
    var searchResults: [Book] {
            // trim whitespace
            let trimmedSearchText = search.trimmingCharacters(in: .whitespaces)

            return books.filter { book in
                if search.isEmpty == false {
                    // If we have search text, make sure this item matches.
                    if book.title.localizedCaseInsensitiveContains(trimmedSearchText) == false {
                        return false
                    }
                }

                if currentTokens.isEmpty == false {
                    // If we have search tokens, loop through them all to make sure one of them matches our movie.
                    for token in currentTokens {
                        if token.title.localizedCaseInsensitiveContains(book.subject) {
                            return true
                        }
                    }

                    // This movie does *not* match any of our tokens, so it shouldn't be sent back.
                    return false
                }

                // If we're still here then the movie should be included.
                return true
            }
        }

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(searchResults) { item in
                    NavigationLink {
                        Text("\(item.title)")
                        
                        
                        ForEach(item.authors, id: \.self) { authors in
                            Text("\(authors)")
                            
                        }
                        
                    } label: {
                        VStack {
                            Text("\(item.title)")
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("\(item.subject)")
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
//                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
                }
            }
//            .searchable(text: $search, prompt: "Search by title, subject, author")
            .searchable(text: $search, tokens: $currentTokens, suggestedTokens: .constant(suggestedTokens), prompt: Text("Type to filter, or use # for tags")) { token in
                           Text(token.title)
                       }
        } detail: {
            Text("Select an item")
        }
    }
    


}

#Preview {
    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
}
