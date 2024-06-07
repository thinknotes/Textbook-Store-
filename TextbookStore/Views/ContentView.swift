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
        
         "All",
         "Math",
         "Science",
         "English",
         "Art - Humanity",
         "History",
         "Other"
    
    ]
    
    
    
    @State var selectedSubject = "All"
    
    let books = [
        Book(title: "Prinplces of enginer", subject: "Math", authors: ["Sam GoodsBugr"], pdf: "", image: Image(systemName: "book.pages.fill")),
        Book(title: "History of the world", subject: "History", authors: ["Leonard Lee"], pdf: "", image: Image(systemName: "book.pages.fill")),
        Book(title: "Spainsh 101", subject: "Other", authors: ["Maria Gonzulezs"], pdf: "", image: Image(systemName: "book.pages.fill"))
    
    ]
    
    @State private var currentTokens = [Token]()
    
    
    @State private var bookPages: Int = 186
    @State private var bookLangauge: String  = "EN"
    @State private var bookRating: Double = 4.5
    @State private var bookDesc: String = ""
    
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
                if book.subject != selectedSubject && selectedSubject != "All"{
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
                        VStack {
                            HStack {
                                Button(action: {
                                    
                                }, label: {
                                    Image(systemName: "bookmark")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.gray)
                                        .offset(y: 60)

                                })
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                
                                Spacer()
                             
                            }
                            
                            Spacer()
                            
                            VStack {
                                VStack {
                                    Image(systemName: "book.pages.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 200, height: 300)
//                                        .border(.primary)
                                        .padding()
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .offset(y: 60)
                                    
                                    VStack {
                                        VStack {
                                            Text("\(bookPages)")
                                                .bold()
                                            
                                            Text("Pages")
                                                .foregroundColor(.gray)
                                                .font(.headline)
                                        }
                                        .padding()
                                        
                                        VStack {
                                            Text("\(bookLangauge)")
                                                .bold()
                                            
                                            Text("Langauge")
                                                .foregroundColor(.gray)
                                                .font(.headline)
                                        }
                                        .padding()
                                     
                                        
                                        VStack {
                                            Text("\(item.subject)")
                                                .bold()
//                                                .foregroundColor(.yellow)
                                            
                                            Text("Subject")
                                                .foregroundColor(.gray)
                                                .font(.headline)
                                        }
                                        
                                        
                                        
                                        VStack {
                                            Text("\(bookRating.formatted())")
                                                .bold()
                                                .foregroundColor(.yellow)
                                            
                                            Text("Rating")
                                                .foregroundColor(.gray)
                                                .font(.headline)
                                        }
                                        .padding()
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .offset(y: -250)
                                    
                                    Spacer()
                                    Spacer()
                                    
                                   
                                }
                            }
                            
                            VStack {
                                Text("\(item.title)")
                                    .bold()
                                    .font(.title)
                                    .frame(maxWidth: .infinity, alignment: .leading)
//                                    .padding()
                                
                                ForEach(item.authors, id: \.self) { authors in
                                        Text("By: \(authors)")
                                        .foregroundColor(.gray)
//                                        .padding()
                                
                                }
                                
                                .frame(maxWidth: .infinity, alignment: .leading)
//                                .padding()
                                
                                Text("Description: ")
                                    .foregroundColor(.primary)
                                    .bold()
                                    .offset(y: 20)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                
                                if bookDesc.isEmpty {
                                    Text("No decription could be found")
                                        .padding()
                                }
                                    
//                                    .offset(y: 20)
                                
                          
                                Button(action: {
                                    
                                }, label: {
                                    Text("Download \(item.title)")
                                })
                                .buttonStyle(BorderedButtonStyle())
                                
//                                Text("Subject: \(item.subject)")
//                                    .foregroundColor(.gray)
//                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .offset(y: -250)
                        
                            
                            Spacer()
                        }
                        .background(
                            LinearGradient(colors: [Color("Lavender"), Color("Powder blue")], startPoint: .top, endPoint: .bottom)
                        )
                        
 
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
                
                
                

            }
            
            
            
            .toolbar {
               
                ToolbarItem {
                    Picker("Choose a subject", selection: $selectedSubject) {
                    ForEach(allSubjets, id: \.self) { subject in
                        Text("\(subject)")
             
                    }
                        
                }
                    
            }
                
        }
            
        .searchable(text: $search, tokens: $currentTokens, prompt: Text("Type to filter")) { token in
                Text(token.title)
               
            }
            
            
            
           

            

            
        } detail: {
            Text("Select an item")
        }
        
    }
     
    
    
    


}


#Preview("English") {
    ContentView()
    

}


#Preview("German") {
    ContentView()
        .environment(\.locale, Locale(identifier: "DE"))
}
