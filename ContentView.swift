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
    @Query private var items: [Item]
    
    @State var search: String = ""
    
    let allSubjects = [
        
        Token(title: "Math"),
        Token(title: "Science"),
        Token(title: "English"),
        Token(title: "Art - Humanity"),
        Token(title: "History"),
        Token(title: "Other")
    
    ]
    
    let books = [
        Book(title: "Prinplces of enginer", subject: "Math", edition: 3, authors: ["Sam GoodsBugr"], null),
        Book(title: "History of the world", subject: "History", edition: 4, authors: ["Leonard Lee"], null),
        Book(title: "Spainsh 101", subject: "Other", edition: 9, authors: ["Maria Gonzulezs"], null)
    
    ]
    
    @State private var currentTokens = [Token]()
    
    var suggestedTokens: [Token] {
            if search.starts(with: "#") {
                return allSubjects
            } else {
                return []
            }
        }
    
    
    var searchResults: [Book] {
            let trimmedSearchText = search.trimmingCharacters(in: .whitespaces)

            return books.filter { book in
                if search.isEmpty == false {
                    if book.title.localizedCaseInsensitiveContains(trimmedSearchText) == false {
                        return false
                    }
                }

                if currentTokens.isEmpty == false {
                    for token in currentTokens {
                        if token.title.localizedCaseInsensitiveContains(book.subject) {
                            return true
                        }
                    }

                    return false
                }

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
                            
                            Text("\(item.pdf)")
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                    } label: {
                        VStack {
                            Text("\(item.title), \(item.edition)rd edition")
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("\(item.subject)")
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
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

    private func addItem() {
        withAnimation {
            let newItem = Item(title: "Prinplces of enginer", subject: "Math", edition: 3, authors: ["Sam GoodsBugr"])
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
