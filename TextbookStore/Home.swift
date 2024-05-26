//
//  Home.swift
//  TextbookStore
//
//  Created by Avi Bansal on 5/25/24.
//

import SwiftUI

struct Home: View {
    
    
    @State private var selectedTab: Tab = .house
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        
        ZStack {
            VStack {
                TabView(selection: $selectedTab) {
                    ForEach(Tab.allCases, id: \.rawValue) { tab in
                        HStack {
                            switch selectedTab {
                            case .house:
                                HomePage()
                            case .book:
                                Text("")
                            case .plus:
                                Text("")
                            case .dollarsign:
                                Text("")
                            }
                        }
                        .tag(tab)
                    }
                }
            }
            
            VStack {
                Spacer()
                Tabbar(selectedTab: $selectedTab)
            }
        }
    }
}

#Preview {
    Home()
}


struct HomePage: View {
    
    @State var subjects: [String] =
    [
        "Math",
        "Science",
        "English",
        "Art - Humanity",
        "History",
        "Other"
    ]
    
    let books = [
        Book(title: "Prinplces of enginer", subject: "Math", authors: ["Sam GoodsBugr"], pdf: "", image: Image(systemName: "book.pages.fill")),
        Book(title: "History of the world", subject: "History", authors: ["Leonard Lee"], pdf: "", image: Image(systemName: "book.pages.fill")),
        Book(title: "Spainsh 101", subject: "Other", authors: ["Maria Gonzulezs"], pdf: "", image: Image(systemName: "book.pages.fill"))
    
    ]
    
    var body: some View {
        VStack {
            VStack {
                Text("Hi, Student!")
                    .foregroundColor(.primary)
                    .bold()
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding()
                
                Text("Find your next textbook here")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.gray)
//                    ./*padding()*/
            }
            .padding()
            
//            Spacer()
            
            VStack {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(subjects, id: \.self) { sub in
                           Button(action: {
                               
                           }, label: {
                               Text(sub)
                                   .padding()
                                   .foregroundColor(.white)
                                  
                           })
                           .background(.ultraThickMaterial)
                           .cornerRadius(15)
                            
                                
                        }
                    }
                }
            }
            .padding()
            
            
            ScrollView(.vertical) {
                
                ForEach(subjects, id: \.self) { subject in
                    Text("\(subject) Textbooks")
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    ScrollView(.horizontal) {
                            ForEach(books) { book in
                                if book.subject == subject {
                                    Image(systemName: "book.pages.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 100, height: 100)
                                    
                                    Text("\(book.title)")
                                        .padding()
                                        .foregroundColor(.primary)
                                        .bold()
                                    
                                    ForEach(book.authors, id: \.self) { author in
                                        Text("By \(author)")
                                            .foregroundColor(.gray)
                                            .offset(y: -15)
                                    }
                                }
                            }
                        }
                    }
                
                Text("Opps it looks like you reach the end.")
                    .foregroundColor(.white)
                    .bold()
                Text("Dont worry we  have \(books.count) books... and counting!")
                    .foregroundColor(.gray)
                }
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
    }
}

#Preview {
    HomePage()
}
