//
//  ContentView.swift
//  TextbookStore
//
//  Created by Avi Bansal on 5/19/24.
//

import SwiftUI
import SwiftData
import SwiftyJSON
import SDWebImageSwiftUI
import WebKit

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    //Google Books Api
    
    @ObservedObject var googlebooks = getDataFromGoogle()
    @State var url: String = ""
    @State var show: Bool = false
//    @Query private var items: [Item]
    
    @State var search: String = ""
    
    @State var isActive: Bool = false
    
    let allSubjets = [
        
         "Select a Subject",
         "Math",
         "Science",
         "English",
         "Art - Humanity",
         "History",
         "Other"
    
    ]
    
    
    
    @State var selectedSubject = "Select a Subject"
    
  
    @State private var currentTokens = [Token]()
    
    
    @State private var bookPages: Int = 186
    @State private var bookLangauge: String  = "EN"
    @State private var bookRating: Double = 4.5
    @State private var bookDesc: String = ""
    
    //Camera
 
    @State private var viewCamera: Bool = false
    
    
    //Ipad  Version Variables
    
    @State private var searchbar: String = ""
    @State private var isExpanable: Bool = false
    @State private var isClear: Bool = false
    
    @State private var searchOptions = ["All", "Files", "People"]
    @State private var selectedOption = ""
    
    @State private var viewBook: Bool = false
    
    @Environment(\.openURL) var openURL
    
    @State private var noResultsFound = false
    
    
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
                if book.subject != selectedSubject && selectedSubject != "Select a Subject"{
                    return false
                }
                
                // If we're still here then the movie should be included.
                return true
            }
        }

    var body: some View {
        
        
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            NavigationSplitView {
                VStack(spacing: 12) {
                    
                    VStack {
                        Text("Database Search")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .bold()
                            .font(.title2)
                        
                        Text("\(googlebooks.numberOfBooksAvailable())  Books Available ")
                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .padding()
                            .font(.caption)
                            .padding(.horizontal)
                    }
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .font(.title3)
                        
                        
                        TextField("Search textbooks, authors, subject", text: $search, onCommit: {
                            // Perform search action when return key is pressed
                            fetchData(query: search)
                            noResultsFound = false
                        })
                        .padding()
                        
                        //                    .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                    }
                    .padding(.horizontal)
//                    .frame(height: 45)
                    .background {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.background)
                    }
                    .padding(.horizontal)
                }
//                .background(.gray.opacity(0.15))
                .background(
                    LinearGradient(colors: [Color("Aquamarine").opacity(0.75), Color("Ocean").opacity(0.75)], startPoint: .top, endPoint: .bottom)
                )

//                .padding(.horizontal)
               
                
              
                
                if noResultsFound {
                    
                    ContentUnavailableView.search(text: "\(search)")
                        .background(
                            LinearGradient(colors: [Color("Aquamarine").opacity(0.75), Color("Ocean").opacity(0.75)], startPoint: .top, endPoint: .bottom)
                        )
                        

                } else {
                    
                    List(googlebooks.data) { item in
                        
                        NavigationLink(destination: {
                            ScrollView(.vertical) {
                                VStack {
                                    VStack {
                                        
                                        
                                        if item.imurl != "" {
                                            WebImage(url: URL(string: item.imurl)!).resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 200, height: 300)
                                                .padding()
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .offset(y: 60)
                                                .blur(radius: isActive ? 20 : 0)
                                        } else {
                                            Image(systemName: "book.pages.fill")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 200, height: 300)
                                                .padding()
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .offset(y: 60)
                                                .blur(radius: isActive ? 20 : 0)
                                        }
                                        
                                        
                                        VStack {
                                            VStack {
                                                Text("\(item.page)")
                                                    .bold()
                                                
                                                Text("Pages")
                                                    .foregroundColor(.gray)
                                                    .font(.headline)
                                            }
                                            .padding()
                                            
                                            VStack {
                                                Text("\(item.language)")
                                                    .bold()
                                                    .textCase(.uppercase)
                                                    
                                                
                                                Text("Langauge")
                                                    .foregroundColor(.gray)
                                                    .font(.headline)
                                            }
                                            .padding()
                                            
                                            
                                            VStack {
                                                Text("\(item.subject)")
                                                    .bold()
                                                
                                                Text("Subject")
                                                    .foregroundColor(.gray)
                                                    .font(.headline)
                                            }
                                            
                                            
                                            
                                            VStack {
                                                Text("\(item.date)")
                                                    .bold()
                                                
                                                
                                                Text("Date Published")
                                                    .foregroundColor(.gray)
                                                    .font(.headline)
                                            }
                                            .padding()
                                        }
                                        .padding()
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .offset(y: -250)
                                        .blur(radius: isActive ? 20 : 0)
                                        
                                        Spacer()
                                        Spacer()
                                        
                                        
                                    }
                                    
                                    VStack {
                                        Text("\(item.title)")
                                            .bold()
                                            .font(.title)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .blur(radius: isActive ? 20 : 0)
                                        //                                    .padding()
                                        
                                        
                                        Text("By: \(item.authors)")
                                            .foregroundColor(.gray)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        //                                .padding()
                                        
                                        Text("Description: ")
                                            .foregroundColor(.primary)
                                            .bold()
                                            .offset(y: 20)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .blur(radius: isActive ? 20 : 0)
                                        
                                        
                                        Text("\(item.desc)")
                                            .foregroundColor(.primary)
                                            .offset(y: 20)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .blur(radius: isActive ? 20 : 0)
                                        
                                        if item.desc.isEmpty {
                                            Text("No decription could be found")
                                                .padding()
                                                .blur(radius: isActive ? 20 : 0)
                                        }
                                        
                                        
                                        Text("Options")
                                            .foregroundColor(.primary)
                                            .bold()
                                            .offset(y: 40)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding()
                                            .padding(.vertical)
                                        
                                        
                                        Grid(horizontalSpacing: 16, verticalSpacing: 16) {
                                            GridRow {
                                                Image("Google Logo")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 40, height: 40)
                                                    .font(.title)
                                                    .foregroundColor(.white)
                                                    
                                                
                                                Spacer()
                                                
                                                VStack(alignment: .leading, spacing: 8) {
                                                    Text("Google Books")
                                                        .font(.headline)
                                                    
                                                
                                                 
                                                    
//                                                    Link("View in webpage", destination: URL(string: "\(item.url)"))
                                                    
                                                    Button(action: {
                                                        if let url = URL(string: "\(item.url)") {
                                                            openURL(url)
                                                        } else {
                                                            print("DEBUG: Invalid URL")
                                                        }
                                                    }, label: {
                                                        Text("View in webpage")
                                                            .foregroundColor(.blue)
                                                    })
                                                    
                                                }
                                            }
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding()
                                        
                                        Grid(horizontalSpacing: 16, verticalSpacing: 16) {
                                            GridRow {
                                                Image(systemName: "plus")
                                                    .font(.title)
                                                    .foregroundColor(.white)
                                                
                                                Spacer()
                                                
                                                VStack(alignment: .leading, spacing: 8) {
                                                    Text("Amazon")
                                                        .font(.headline)
                                                    
                                                
                                                    
                                                    Button(action: {
                                                        
                                                    }, label: {
                                                        Text("View in webpage")
                                                            .foregroundColor(.blue)
                                                    })
                                                    
                                                }
                                            }
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding()
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                    .offset(y: -250)
                                    //
                                    
                                }
                                
                                //
                            }
                            
                            
                        }, label: {
                            HStack {
                                
                                if item.imurl != "" {
                                    WebImage(url: URL(string: item.imurl)!).resizable().frame(width: 120, height: 170).cornerRadius(10)
                                } else {
                                    Image(systemName: "book.pages.fill")
                                        .resizable()
                                        .frame(width: 120, height: 170)
                                        .cornerRadius(10)
                                }
                                
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    
                                    Text(item.title)
                                        .fontWeight(.bold)
                                    
                                    Text(item.authors)
                                    
                                    Text(item.desc)
                                        .font(.caption)
                                        .lineLimit(4)
                                        .multilineTextAlignment(.leading)
                                    
                                    Text(item.date)
                                        .foregroundColor(.gray)
                                        .frame(width: 80, height: 20)
                                        .frame(alignment: .leading)
                                        .bold()
                                        .font(.caption)
                                        .background(Capsule()
                                            .fill(Color.white))
                                }
                            }
                            
                            //                        .onTapGesture {
                            //                            self.url = item.url
                            //                            self.show.toggle()
                            //                        }
                            //
                        })
                        
                        
                        
                        
                        
                        
                        
                    }
                    .background(
                        LinearGradient(colors: [Color("Aquamarine").opacity(0.75), Color("Ocean").opacity(0.75)], startPoint: .top, endPoint: .bottom)
                    )

                    .onAppear {
                        //                    fetchData(query: "math")
                        
                        if search.isEmpty {
                            noResultsFound = true
                        }
                       
                    }
                }
                

            }
            
        detail: {
                Text("Select an item")
            }
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            
            VStack {
              
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(color: .gray, radius: 20, x: 0, y: 10)
                        .frame(width: 550, height: 90)
                    
                    HStack {
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                        
                        
                        TextField("Search textbooks, authors, subject", text: $searchbar, onCommit: {
                            // Perform search action when return key is pressed
                            fetchData(query: searchbar)
                        })
                        .onChange(of: searchbar) { searchText in
                                                          isExpanable = true
                                                          isClear = true
                        }
                        .padding()
                        
//                        TextField("Search textbook, authors, people", text: $searchbar)
//                            .foregroundColor(.primary)
//                            .onChange(of: searchbar) { searchText in
//                                    isExpanable = true
//                                    isClear = true
//                                }
                           
//                            .onAppear {
//                                if searchbar.contains(searchbar) {
//                                    isExpanable = true
//                                }
//                            }
                        
                        if isClear == true {
                            Button(action: {
                                isExpanable = false
                             print("Clear ")
                            }, label: {
                                Text("Clear")
                                    .foregroundColor(.black)
                                    .fontWeight(.semibold)
                                    .underline()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .offset(x: -60)
                            })
                        }
                       
                        
                        
                        
//
//                        Spacer()
                        
                       
                      
                            
//                            RoundedRectangle(cornerRadius: 15)
//                                .stroke(Color.gray, lineWidth: 3)
//                                .frame(width: 40, height: 40)
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                                .offset(x: -10)
//                            
//                            Text("S")
//                            .foregroundColor(.gray)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .offset(x: -10)
                        
                        
                    }
                    .offset(x: 240)
                      
                        
                }
            
                
                
                
                if isExpanable == true {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .shadow(color: .gray, radius: 10, x: 0, y: 10)
                        .frame(width: 550, height: 300)
                        .offset(y: -45)
//                        .blendMode(.overlay)
                    
                    
                    HStack {
                        Picker("", selection: $selectedOption) {
                            ForEach(searchOptions, id: \.self) { option in
                                Text(option)
                            }
                        }
                        .pickerStyle(.segmented)
                        .frame(width: 400, height: 300)
                        .offset(y: -460)
                        .padding()
                        
                       
                        
                        Button(action: {
                          
                         
                        }, label: {
                            Image(systemName: "gear")
                                .foregroundColor(.gray)
                                .fontWeight(.semibold)
//
                               
                        })
                        .offset(y: -460)
                        .padding()
                        
                        Button(action: {
                            viewCamera.toggle()
                        }, label: {
                            Image(systemName: "camera.fill")
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                                
                               
                        })
                        .offset(y: -460)
                        .sheet(isPresented: $viewCamera, content: {
                            Scanner()
                        })
                        
                      
                        
                    }
                    
                    VStack {
                        if searchbar.isEmpty {
                            Text("Nothing Searched")
                                .bold()
                                .offset(x: -300, y: 30)
                        } else {
                            List(googlebooks.data) { item in
                                HStack {
                                    if item.imurl != "" {
                                        WebImage(url: URL(string: item.imurl)!).resizable()
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 40, height: 40)
                                            .foregroundColor(.black)
                                        
//                                            .aspectRatio(contentMode: .fit)
//                                            .frame(width: 200, height: 300)
//                                            .padding()
//                                            .frame(maxWidth: .infinity, alignment: .leading)
//                                            .offset(y: 60)
//                                            .blur(radius: isActive ? 20 : 0)
                                    } else {
                                        Image(systemName: "book.pages.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 40, height: 40)
                                            .foregroundColor(.black)
                                    }
                                    
                                    
                               
                                    
                                    
                                    
                                    VStack {
                                        Text("\(item.title)")
                                            .bold()
                                            .font(.headline)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .foregroundColor(.black)
                                        //                                        .padding()
                                        
                                        
                                        
//                                        Text("By: \(item.authors)")
//                                                .foregroundColor(.gray)
//                                                .frame(maxWidth: .infinity, alignment: .leading)
                                       
                                        Text("By: \(item.authors)")
                                                .foregroundColor(.gray)
                                                .font(.caption)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            //                                        .padding()
                                            
                                        
                                       
                                        
                                        
                                        
                                    }
                                    
                                    HStack {
                                        Button(action: {
                                            
                                        }, label: {
                                            Image(systemName: "link")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 20, height: 20)
                                                .foregroundColor(.black)
                                        })
//                                        .offset(x: -180)
                                        
                                        Button(action: {
                                            viewBook.toggle()
                                        }, label: {
                                            
                                            
                                            
                                            Image(systemName: "arrow.up.forward.app")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 20, height: 20)
                                                .foregroundColor(.black)
                                            
                                            Text("View Book")
                                                .foregroundColor(.black)
                                        })
                                        .offset(x: -160)
                                        
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .border(Color.red)
                                    .sheet(isPresented: $viewBook, content: {
                                        VStack {
//                                            HStack {
//                                                Button(action: {
//                                                    viewBook.toggle()
//                                                }, label: {
//                                                    Image(systemName: "xmark")
//                                                        .resizable()
//                                                        .aspectRatio(contentMode: .fit)
//                                                        .frame(width: 20, height: 20)
//                                                        .foregroundColor(.black)
//                                                })
//                                                .frame(maxWidth: .infinity, alignment: .trailing)
//                                                .padding()
                                                
                                                
                                                
                                          
                                                    
                                                        VStack {
                                                            HStack {
                                                                Button(action: {
                                                                    
                                                                }, label: {
                                                                    Image(systemName: "bookmark")
                                                                        .resizable()
                                                                        .aspectRatio(contentMode: .fit)
                                                                        .frame(width: 30, height: 30)
                                                                        .foregroundColor(.gray)
                                                                        .offset(x: 300, y: 60)
                                                                    
                                                                })
                                                                .frame(maxWidth: .infinity, alignment: .trailing)
                                                                
                                                                
                                                              
//                                                                .frame(maxWidth: .infinity, alignment: .trailing)
                                                                
//                                                                Spacer()
                                                                
                                                            }
                                                            
//                                                            Spacer()
                                                            
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
                                                                        .blur(radius: isActive ? 20 : 0)
                                                                    
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
                                                                    .blur(radius: isActive ? 20 : 0)
                                                                    
                                                                    Spacer()
                                                                    Spacer()
                                                                    
                                                                    
                                                                }
                                                            }
                                                            
                                                            VStack {
                                                                Text("\(item.title)")
                                                                    .bold()
                                                                    .font(.title)
                                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                                    .blur(radius: isActive ? 20 : 0)
                                                                    .offset(y: -300)
                                                                //                                    .padding()
                                                                
                                                               
                                                                Text("By: \(item.authors)")
                                                                        .foregroundColor(.gray).blur(radius: isActive ? 20 : 0)
                                                                       .offset(y: -300)
                                                                
                                                                
                                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                                //                                .padding()
                                                                
                                                                Text("Description: ")
                                                                    .foregroundColor(.primary)
                                                                    .bold()
                                                                    .offset(y: 20)
                                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                                    .blur(radius: isActive ? 20 : 0)
                                                                    .offset(y: -300)
                                                                
                                                                
                                                                if bookDesc.isEmpty {
                                                                    Text("No decription could be found")
                                                                        .padding()
                                                                        .blur(radius: isActive ? 20 : 0)
                                                                }
                                                                
                                                                
                                                                if isActive {
                                                                    CustomDialog(isActive: $isActive, title: "Are you sure?", message: "By agreeing to download, you waive your rights and know you may be breaking the law", buttonTitle1: "I Understand", buttonTitle2: "Go Back To Safety", action: {}, action1: {})
                                                                        .offset(y: -200)
                                                                }
                                                                
                                                                
                                                                //                                    .offset(y: 20)w
                                                                
                                                                VStack {
//                                                                    Link("Open \(item.title)", destination: URL(string: "\(item.pdf)")!)
//                                                                    .blur(radius: isActive ? 20 : 0)
                                                                    //
                                                                    
                                                                    Button(action: {
                                                                        viewBook.toggle()
                                                                    }, label: {
                                                                        Image(systemName: "xmark")
                                                                            .resizable()
                                                                            .aspectRatio(contentMode: .fit)
                                                                            .frame(width: 20, height: 20)
                                                                            .foregroundColor(.black)
                                                                            .offset(y: 60)
                                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                                        
                                                                    })
//                                                                    .padding()
                                                                }
                                                                
                                                                
                                                            }
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                            .padding()
//                                                            .offset(y: -250)
                                                            //                            .offset(y: isActive ? -250 : 0)
                                                            
                                                            
                                                            
                                                            
                                                            
                                                            
                                                            
                                                            Spacer()
                                                        }
                                                        .background(
                                                            LinearGradient(colors: [Color("Aquamarine").opacity(0.75), Color("Ocean").opacity(0.75)], startPoint: .top, endPoint: .bottom)
                                                        )
                                                        
                                                        
                                                        
                                                    
                                                
                                            
                                            
//                                            Spacer()
                                        }
                                    })
                                    
                                }
                                //                            ./*padding()*/
                            }
                            .onAppear {
                                fetchData(query: "math")
                            }
                        }
                    }
//                    .padding(.horizontal)
                    .offset(x: 150,y: -650)
                    .border(.red)
                    
                }
                
                
//                TextField("Search textbook, authors, people", text: $searchbar)
//                    .frame( alignment: .center)
            }
            .padding()
            
            
        }
          
        
    }
    
    private func fetchData(query: String) {
        googlebooks.data.removeAll()
        googlebooks.fetchData(query: query) { sucess in
            if !sucess {
                       print("No books found for the query: \(query)")
            } else {
                       print("Books successfully fetched.")
        }
            
        }
    }
     
    
    func subjectColor(for subject: String) -> Color {
        switch subject {
        case "Math":
            return Color.red
        case "Science":
            return Color.blue
        case "English":
            return Color.green
        case "Art - Humanity":
            return Color.orange
        case "History":
            return Color.purple
        case "Other":
            return Color.yellow
        default:
            return Color.black
        }
    }
    

    class getDataFromGoogle: ObservableObject {
        @Published var data = [GoogleBook]()
        
        func fetchData(query: String, completion:  @escaping (Bool) -> Void){
            let formattedQuery = query.replacingOccurrences(of: " ", with: "+")
            let url = "https://www.googleapis.com/books/v1/volumes?q=\(formattedQuery)"
            
            let session = URLSession(configuration: .default)
            
            session.dataTask(with: URL(string: url)!) { (data, _, err) in
                if err != nil {
                    print((err?.localizedDescription)!)
                    completion(false)
                    return
                }
                
                
                
                let json = try! JSON(data: data!)
                
                let items = json["items"].array!
                
                DispatchQueue.main.async {
                    self.data.removeAll()
                }
           
        
                if items.isEmpty {
                    completion(false)
                } else {
                    
                    for i in items {
                        let id = i["id"].stringValue
                        
                        let title = i["volumeInfo"]["title"].stringValue
                        
                        //                    let authors = i["volumeInfo"]["authors"].stringValue
                        
                        let authors = i["volumeInfo"]["authors"].arrayValue.map { $0.stringValue }
                        
                        //                    let authors = i["volumeInfo"]["authors"].array
                        
                        var author = ""
                        
                        for j in authors {
                            author += "\(j)"
                        }
                        
                        let description = i["volumeInfo"]["description"].stringValue
                        
                        let imurl = i["volumeInfo"]["imageLinks"]["thumbnail"].stringValue
                        
                        let url1 = i["webReaderLink"].stringValue
                        
                        let pubdate = i["volumeInfo"]["publishedDate"].stringValue
                        
                        let formattedDate = self.formatDate(pubdate)
                        
                        let subject = i["volumeInfo"]["categories"].stringValue
                        
                        let pages = i["volumeInfo"]["pageCount"].stringValue
                        
                        let lang = i["volumeInfo"]["language"].stringValue
                        
                        DispatchQueue.main.async {
                            self.data.append(GoogleBook(id: id, title: title, authors: author, desc: description, imurl: imurl, url: url1, date: formattedDate, subject: subject, page: pages, language: lang))
                        }
                    }
                    completion(true)
                }
                    
            }
            .resume()
        }
        
        func numberOfBooksAvailable() -> Int {
                return data.count
        }
        
         func formatDate(_ dateString: String) -> String {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd" // Assuming input date format from API
                guard let date = dateFormatter.date(from: dateString) else {
                    return dateString // Return original string if date conversion fails
                }
                
                // Convert date to US date format
                let usDateFormatter = DateFormatter()
                usDateFormatter.dateFormat = "MM/dd/yyyy"
                
                return usDateFormatter.string(from: date)
        }
    }
    
    struct GoogleBook: Identifiable {
        var id: String
        var title: String
        var authors: String
        var desc: String
        var imurl: String
        var url: String
        var date: String
        var subject: String
        var page: String
        var language: String
      
    }
    
    struct GoogleBookWebPage: UIViewRepresentable {
        var url: String
        
        func makeUIView(context: UIViewRepresentableContext<GoogleBookWebPage>) -> WKWebView{
            
            let view = WKWebView()
            view.load(URLRequest(url: URL(string: url)!))
            return view
        }
        
        func updateUIView(_ uiView: WKWebView, context:  UIViewRepresentableContext<GoogleBookWebPage>) {
                
            }
        }
    }




#Preview("English") {
    ContentView()
        

        
        
    

}


#Preview("German") {
    ContentView()
        .environment(\.locale, Locale(identifier: "DE"))
        .environmentObject(CameraViewModel())
}
