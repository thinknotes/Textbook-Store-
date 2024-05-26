//
//  Add.swift
//  TextbookStore
//
//  Created by Avi Bansal on 5/25/24.
//

import SwiftUI

struct Add: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
     private func addBook() {
            withAnimation {
                let newBook = Book(title: "Prinplces of enginer", subject: "Math", authors:  ["Sam GoodsBugr"], pdf: "", image: Image(systemName: "book.pages.fill"))
                //modelContext.insert(newBook)
            }
        }

        private func deleteBook(offsets: IndexSet) {
            withAnimation {
                for index in offsets {
                  
                }
            }
        }
}

#Preview {
    Add()
}
