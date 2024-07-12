//
//  Home.swift
//  TextbookStore
//
//  Created by Avi Bansal on 5/25/24.
//

import SwiftUI
import SwiftData
import SwiftyJSON
import SDWebImageSwiftUI
import WebKit

//enum views: Hashable {
//    case home, search, grads, pay
//}


struct Home: View {
    
    
    @State private var selectedTab: Tabs = .house
    
//    @State private var page: views = .home
    
   
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        
        ZStack {
            
            if UIDevice.current.userInterfaceIdiom == .phone {
                
                
                VStack {
                    TabView(selection: $selectedTab) {
                        ForEach(Tabs.allCases, id: \.rawValue) { tab in
                            HStack {
                                switch selectedTab {
                                case .house:
                                    HomePage()
                                        
                                case .book:
                                    ContentView()
                                    
                                case .plus:
                                    Grad()
                                case .dollarsign:
                                    Text("")
                                    
                                case .gear:
                                    settings()
                                }
                            }
                            .tag(tab)
                        }
                    }
                }
            } else if UIDevice.current.userInterfaceIdiom == .pad {
                VStack {
                    TabView(selection: $selectedTab) {
                        ForEach(Tabs.allCases, id: \.rawValue) { tab in
                            HStack {
                                switch selectedTab {
                                case .house:
                                    HomePage()
                                       
                                case .book:
                                    ContentView()
                                    
                                case .plus:
                                    Grad()
                                case .dollarsign:
                                    Text("")
                                    
                                case .gear:
                                    settings()
                                }
                            }
                            .tag(tab)
                        }
                    }
//                    if #available(iOS 18, *){
////                        TabView(selection: $page) {
////                            
////                            Tab("Home", systemImage: "house", value: .home) {
////                                HomePage()
////                            }
////                            
////                            Tab("Search", systemImage: "magnifyingglass",  value: .search) {
////                                ContentView()
////                            }
////                            
////                            Tab("My Path", systemImage: "book", value: .grads) {
////                                Grad()
////                            }
////                            
////                            Tab("Pay", systemImage: "dollarsign", value: .pay) {
////                                Text("")
////                            }
////                            
//////
////                        }
////                        .tabViewStyle(.sidebarAdaptable)
//            
//                    } else if #available(iOS 17, *) {
//                        TabView(selection: $selectedTab) {
//                            
//                            ForEach(Tabs.allCases, id: \.rawValue) { tab in
//                                HStack {
//                                    
//                                    switch selectedTab {
//                                    case .house:
//                                        HomePage()
//                                    case .book:
//                                        ContentView()
//                                        
//                                    case .plus:
//                                        Grad()
//                                    case .dollarsign:
//                                        Text("")
//                                    }
//                                }
//                                .tag(tab)
//                            }
//                        }
//                        
//                        //                    Text("This is an iPad, and it's running iPadOS!")
//                        
//                    }
                }
            }
            
            
           
            VStack {
                Spacer()
                Tabbar(selectedTab: $selectedTab)
            }
            
            
        }
        


    }
}

#Preview("English - Home") {
    Home()
       
}

#Preview("German - Home") {
    Home()
        .environment(\.locale, Locale(identifier: "DE"))
    
    
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
    
    
    
    @State  var selectedSubject = ""
    
    //Ipad Var
    
    @State var quickLink: Bool = false
    

    
    @State var search = ""
    
    //Google Book Api
    
    @ObservedObject var mathtextbookdata = FindMathTextbook()
    @ObservedObject var sciencetextbookdata = FindScienceTextbook()
    @ObservedObject var englishtextbookdata = FindEnglishTextbook()
    @ObservedObject var arttextbookdata = FindArtTextbook()
    @ObservedObject var historytextbookdata = FindHistoryTextbook()
    
    @State var openGoogle: Bool = false
    @State var url: String = ""
    
    
    //Setting View Model
    
    
    //Bookmark
    @State private var showBookmark: Bool = false
    @State private var addBookmark: Bool = false
    
    
    //Bookmark Alert Var
    @State var bookAler: Bool = false
    @State var scienceAlert: Bool = false
    @State var englishAlert: Bool = false
    @State var artAlert: Bool = false
    @State var historyAlert: Bool = false
    
    
    //Bookmark Sucess Var
    
    @State var isSuccesfully: Bool = false
    @State var scienceSucessfully: Bool = false
    @State var englishSucessfully: Bool = false
    @State var artSucessfully: Bool = false
    @State var historySucessfully: Bool = false
    
    //Bookmark IsDelete Var
    
    @State var isDeleted: Bool = false
    @State var scienceDelete: Bool = false
    @State var englishDelete: Bool = false
    @State var artDelete: Bool = false
    @State var historyDelete: Bool = false
    
    
    //Help
    @State private var showHelp: Bool = false
  
//     var bm  = bookmarkItem(title: "", author: "", imurl: "", timestamp: Date())
    
    //More Bookmark var lol
    @State var bm = [bookmarkItem]()
    @AppStorage("bookmarks") private var bookmarksData: Data = Data()
    @State private var alertMessage = ""
    
    let colors: [Color] = [
        .red,
        .green,
        .yellow,
        .blue,
        .purple,
        .pink,
        .cyan,
        .indigo,
        .mint,
        .orange,
        .teal
    
    
    ]
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "bookmarks"){
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([bookmarkItem].self, from: data) {
                self._bm = State(initialValue: decoded)
            }
        }
    }

   
    
//    @Query(sort: \bookmarkItem.author) var bm: [bookmarkItem]
   
//    @Environment(\.modelContext) var context 
//    @Query var itms: [bookmarkItem]
    
    var body: some View {
        
        //MARK: IPhone
        if UIDevice.current.userInterfaceIdiom == .phone {
            NavigationView {
                VStack {
                    VStack {
                        HStack {
                            Text("Hi, Student!")
                                .foregroundColor(.primary)
                                .bold()
                                .font(.title)
                                .frame(maxWidth: .infinity, alignment: .leading)
                               
                            
                            
                            
                            
                            
                            Button(action: {
                                showBookmark.toggle()
                            }, label: {
                                Image(systemName: "bookmark.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.primary)
                                
                            })
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .sheet(isPresented: $showBookmark, content: {
                                NavigationStack {
                                    List {
                                        
                                        ForEach(bm) { bookmarks in
                                            HStack {
                                           
                                                    
                                                if bookmarks.imurl != "" {
                                                    WebImage(url: URL(string: bookmarks.imurl)!).resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .background(colors.randomElement()!.gradient)
                                                        .frame(width: 100, height: 70)
                                                        .padding()
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                                
                                                } else {
                                                    Image(systemName: "book.pages.fill")
                                                             .resizable()
                                                             .aspectRatio(contentMode: .fit)
                                                             .background(colors.randomElement()!.gradient)
                                                             .frame(width: 200, height: 70)
                                                             .padding()
                                                             .frame(maxWidth: .infinity, alignment: .leading)
//                                                              .offset(y: 60)
                                                }
                                                

                                                
                                                VStack(alignment: .leading) {
                                                    Text(bookmarks.title)
                                                        .font(.system(.title2, design: .rounded, weight: .semibold))
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                    
                                                    Text("Author: \(bookmarks.author)")
                                                        .font(.system(.caption, design: .rounded, weight: .bold))
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                    
                                                    
                                                    Text("Added: \(bookmarks.timestamp)")
                                                        .font(.system(.caption, design: .rounded, weight: .bold))
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                }
//                                                Text(bookmarks.title)
//                                                Spacer()
//                                                Text(bookmarks.author)
                                            }
                                            .swipeActions {
                                                Button(role: .destructive) {
                                                    removeBookmark(bookmarks)
                                                    isDeleted = true
                                                    scienceDelete = true
                                                    englishDelete = true
                                                    artDelete = true
                                                    historyDelete = true
                                                } label: {
                                                    Label("Delete", systemImage: "trash")
                                                }
                                                
                                                Button {
                                                    
                                                } label: {
                                                    Label("Edit", systemImage: "pencil")
                                                }
                                                .tint(Color.blue)
                                            }
                                        }
                                        
                                    }
                                    .navigationTitle("Bookmarks")
                                    .navigationBarTitleDisplayMode(.large)
                                    .sheet(isPresented: $addBookmark) { AddBookMark(bm: $bm) }
                                    .onAppear {
                                        loadBookmarks()

                                    }
                                    .toolbar {
                                        if !bm.isEmpty {
                                            Button(action: {
                                                addBookmark = true
                                            }, label: {
                                                Image(systemName: "plus")
                                                    .foregroundColor(.white)
                                            })
//
                                            Button(action: {
                                                showHelp.toggle()
                                            }, label: {
                                                Image(systemName: "questionmark.circle.fill")
                                                    .foregroundColor(.white)
                                            })
                                            .sheet(isPresented: $showHelp) {
                                                VStack {
                                                    
                                                    Button(action: {
                                                        showBookmark.toggle()
                                                    }, label: {
                                                        Image(systemName: "xmark")
                                                            .symbolVariant(.fill.circle)
                                                            .font(.system(.title2, design: .rounded, weight: .bold))
                                                            .foregroundStyle(Color(uiColor: .systemGray3))
                                                    })
                                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                                    
                                                    Text("Bookmark Help")
                                                        .fontWeight(.semibold)
                                                        .font(.largeTitle)
                                                        .padding()
                                                    
                                                    Grid(horizontalSpacing: 16, verticalSpacing: 16) {
                                                        GridRow {
                                                            Image(systemName: "plus")
                                                                .font(.title)
                                                                .foregroundColor(.white)
                                                            
                                                            VStack(alignment: .leading, spacing: 8) {
                                                                Text("Add")
                                                                    .font(.headline)
                                                                
                                                                Text("Create custom bookmarks")
                                                                    .foregroundColor(.secondary)
                                                            }
                                                        }
                                                    }
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .padding()
                                                    
                                                    Grid(horizontalSpacing: 16, verticalSpacing: 16) {
                                                        GridRow {
                                                            Image(systemName: "bookmark")
                                                                .font(.title)
                                                                .foregroundColor(.white)
                                                            
                                                            VStack(alignment: .leading, spacing: 8) {
                                                                Text("Bookmark Books")
                                                                    .font(.headline)
                                                                
                                                                Text("The bookmark indicates that this \n book has not been \nbookmarked yet. ")
                                                                    .foregroundColor(.secondary)
                                                            }
                                                        }
                                                    }
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .padding()
                                                    
                                                    Grid(horizontalSpacing: 16, verticalSpacing: 16) {
                                                        GridRow {
                                                            Image(systemName: "bookmark.fill")
                                                                .font(.title)
                                                                .foregroundColor(.white)
                                                            
                                                            VStack(alignment: .leading, spacing: 8) {
                                                                Text("Book Has Been Bookmarked")
                                                                    .font(.headline)
                                                                
                                                                Text("The bookmark indicate the book has been bookmarked successfully.  ")
                                                                    .foregroundColor(.secondary)
                                                            }
                                                        }
                                                    }
                                                    
                                                    Text("To view bookmark go to the home page and click the button next to hello student.")
                                                        .bold()
                                                        .foregroundColor(.secondary)
                                                        .padding()
                                                }
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .padding()
//                                                .padding()
                                                
                                                Spacer()
                                                
//                                                Button("Close") {
//                                                    showHelp.toggle()
//                                                }
//                                                .buttonStyle(.borderedProminent)
                                            }
                                            
                                            Button(action: {
                                                showBookmark.toggle()
                                            }, label: {
                                                Image(systemName: "xmark")
                                                    .symbolVariant(.fill.circle)
                                                    .font(.system(.title2, design: .rounded, weight: .bold))
                                                    .foregroundStyle(Color(uiColor: .systemGray3))
                                            })
                                        } else {
                                            Button(action: {
                                                showBookmark.toggle()
                                            }, label: {
                                                Image(systemName: "xmark")
                                                    .symbolVariant(.fill.circle)
                                                    .font(.system(.title2, design: .rounded, weight: .bold))
                                                    .foregroundStyle(Color(uiColor: .systemGray3))
                                            })
                                        }
                                    }
                                    .overlay {
                                            if bm.isEmpty {
                                                ContentUnavailableView(
                                                    label: {
                                                        Label("No Bookmarks", systemImage: "bookmark.fill")
                                                    },
                                                    description: {
                                                        Text("Start adding bookmarks to see your list")
                                                    },
                                                    actions: {
                                                        Button("Add Bookmark") {
                                                            addBookmark = true
                                                        }
                                                    }
                                                )
                                                .offset(y: -60)
                                            } else {
                                                EmptyView() // Ensures there's always something in the overlay
                                            }
                                        }
                                    
                                }
//
                            })
                        }
                        .padding(.vertical)
                        
                        
                        Text("Find your next textbook here")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.gray)
                            
                    }
                    .padding()
                    
                    
                    VStack {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(subjects, id: \.self) { sub in
                                    
                                    Button(action: {
                                        quickLink.toggle()
                                    }, label: {
                                        Text(sub)
                                           .padding()
                                           .foregroundColor(.primary)
                                    })
                                    .background(.ultraThickMaterial)
                                    .cornerRadius(15)
                                    
//                                    NavigationLink(destination: {
//                                        ContentView()
//                                    }, label: {
//                                        Text(sub)
//                                            .padding()
//                                            .foregroundColor(.primary)
//                                    })
//                                    
//                                    .background(.ultraThickMaterial)
//                                    .cornerRadius(15)
                                }
                                .sheet(isPresented: $quickLink, content: {
                                    ContentView()
                                })
                            }
                        }
                    }
                    .padding()
                    
                    
                    ScrollView(.vertical) {
                        
                        if !bm.isEmpty {
                            Text("Continue Reading")
                                .foregroundColor(.primary)
                                .bold()
                                .padding()
                                .font(.title3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(bm) { cr in
                                        
                                        
                                        if cr.imurl != "" {
                                            WebImage(url: URL(string: cr.imurl)!).resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .background(colors.randomElement()!.gradient)
                                                .frame(width: 150, height: 150)
                                                .padding()
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            
                                        } else {
                                            Image(systemName: "book.pages.fill")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .background(colors.randomElement()!.gradient)
                                                .frame(width: 150, height: 150)
                                                .padding()
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            //                                                              .offset(y: 60)
                                        }
                                        
                                    }
                                }
                            }
                        }
                 
                        //
                        VStack {
                            Text("Math Textbooks")
                                .foregroundColor(.primary)
                                .bold()
                                .padding()
                                .font(.title3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                         
                            
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(mathtextbookdata.data) { i in
                                        NavigationLink(destination: {
                                               ScrollView(.vertical) {
                                                VStack {
                                                    VStack {
                                                        
                                                        
                                                        if i.imurl != "" {
                                                            WebImage(url: URL(string: i.imurl)!).resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .frame(width: 200, height: 300)
                                                                .padding()
                                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                                .offset(y: 60)
                                                            
                                                            
                                                          
                                                        } else {
                                                            Image(systemName: "book.pages.fill")
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .frame(width: 200, height: 300)
                                                                .padding()
                                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                                .offset(y: 60)
                                                            
                                                        }
                                                        
                                                        
                                                        VStack {
                                                            VStack {
                                                                Text("\(i.page)")
                                                                    .bold()
                                                                
                                                                Text("Pages")
                                                                    .foregroundColor(.gray)
                                                                    .font(.headline)
                                                            }
                                                            .padding()
                                                            
                                                            VStack {
                                                                Text("\(i.language)")
                                                                    .bold()
                                                                
                                                                Text("Langauge")
                                                                    .foregroundColor(.gray)
                                                                    .font(.headline)
                                                            }
                                                            .padding()
                                                            
                                                            
                                                            VStack {
//                                                                Text("\(i.subject)")
//                                                                    .bold()
//                                                                //                                                .foregroundColor(.yellow)
//                                                                
//                                                                Text("Subject")
//                                                                    .foregroundColor(.gray)
//                                                                    .font(.headline)
                                                                
                                                                Button(action: {
                                                                    isDeleted = false

                                                                    addBookmark(title: "\(i.title)", author: "\(i.authors)", imurl: "\(i.imurl)")
                                                                    

                                                                    saveBookmarks()
//
                                                                }, label: {
                                                                    if isDeleted == true {
                                                                        Image(systemName: "bookmark")
                                                                            .foregroundColor(.white)

                                                                    } else {
                                                                        Image(systemName: isSuccesfully ? "bookmark.fill" : "bookmark")
                                                                            .foregroundColor(.white)
                                                                    }
                                                                })
                                                                .alert(isPresented: $bookAler) {
                                                                    if isSuccesfully {
                                                                                       Alert(title: Text("Bookmark Added"), message: Text("View bookmarks in the homepage under bookmarks"), dismissButton: .default(Text("Dismiss")))
                                                                    } else {
                                                                                       Alert(title: Text("Bookmark Already Exists"), message: Text("This bookmark is already in your list."), dismissButton: .default(Text("Dismiss")))
                                                                    }
                                                                }
                                                                .sheet(isPresented: $addBookmark, content:  {
                                                                    NavigationStack {
                                                                        
                                                                           
                                                                    }
                                                                    .presentationDetents([.medium])
                                                                })
//                                                                
//                                                                Text("Bookmark")
//                                                                    .foregroundColor(.gray)
//                                                                    .font(.headline)
                                                            }
                                                            
                                                        
                                                            
                                                            
                                                            VStack {
                                                                Text("\(i.date)")
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
                                                        
                                                        
                                                        Spacer()
                                                        Spacer()
                                                        
                                                        
                                                    }
                                                    
                                                    VStack {
                                                        Text("\(i.title)")
                                                            .bold()
                                                            .font(.title)
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                        
                                                        //                                    .padding()
                                                        
                                                     
                                                        
                                                       
                                                        Text("By: \(i.authors)")
                                                            .foregroundColor(.gray)
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                        //                                .padding()
                                                        
                                                        Text("Description: ")
                                                            .foregroundColor(.primary)
                                                            .bold()
                                                            .offset(y: 20)
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                        
                                                        
                                                        
                                                        Text("\(i.desc)")
                                                            .foregroundColor(.primary)
                                                            .offset(y: 20)
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                        
                                                        
                                                        if i.desc.isEmpty {
                                                            Text("No decription could be found")
                                                                .padding()
                                                            
                                                        }
                                                        //
                                                        
//                                                        Button(action: {
//                                                      
//                                                            show.toggle()
//                                                    }, label: {
//                                                            Text("Open Link")
//                                                        })
//                                                            
//                                                    .onAppear {
//                                                        self.url = i.url
//                                                    }
                                                                               
                                                    }
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .padding()
                                                    .offset(y: -250)
                                                    //                            .background(
                                                    //                                    LinearGradient(colors: [Color("Aquamarine").opacity(0.75), Color("Ocean").opacity(0.75)], startPoint: .top, endPoint: .bottom)
                                                    //                            )
                                                    
                                                    
                                                }
                                            }
                                        }, label: {
                                            HStack {
                                                if i.imurl != "" {
                                                    WebImage(url: URL(string: i.imurl)!)
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 150, height: 150)
                                                    
                                                    //                                            .cornerRadius(10)
                                                } else {
                                                    Image(systemName: "book.fill")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 150, height: 150)
                                                }
                                            }
                                        })
                                       
                                    }
                                    //                            .listRowBackground( LinearGradient(colors: [Color("Aquamarine").opacity(0.75), Color("Ocean").opacity(0.75)], startPoint: .top, endPoint: .bottom))
                                }
                                .frame(height: 200)
                                .padding(.horizontal)
                                
                            }
                            
                        }
                        
                        VStack {
                            Text("Science Textbooks")
                                .foregroundColor(.primary)
                                .bold()
                                .padding()
                                .font(.title3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                         
                            
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(sciencetextbookdata.data) { i in
                                        
                                        NavigationLink(destination: {
                                            ScrollView(.vertical) {
                                                  VStack {
                                                    VStack {
                                                        
                                                        
                                                        if i.imurl != "" {
                                                            WebImage(url: URL(string: i.imurl)!).resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .frame(width: 200, height: 300)
                                                                .padding()
                                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                                .offset(y: 60)
                                                            
                                                        } else {
                                                            Image(systemName: "book.pages.fill")
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .frame(width: 200, height: 300)
                                                                .padding()
                                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                                .offset(y: 60)
                                                            
                                                        }
                                                        
                                                        
                                                        VStack {
                                                            VStack {
                                                                Text("\(i.page)")
                                                                    .bold()
                                                                
                                                                Text("Pages")
                                                                    .foregroundColor(.gray)
                                                                    .font(.headline)
                                                            }
                                                            .padding()
                                                            
                                                            VStack {
                                                                Text("\(i.language)")
                                                                    .bold()
                                                                
                                                                Text("Langauge")
                                                                    .foregroundColor(.gray)
                                                                    .font(.headline)
                                                            }
                                                            .padding()
                                                            
                                                            
                                                            VStack {
                                                                Button(action: {
                                                                    scienceDelete = false
//
                                                                    
                                                                    addBookmark(title: "\(i.title)", author: "\(i.authors)", imurl: "\(i.imurl)")
                                                                   
                                                                    saveBookmarks()
                                                                    
//
                                                                }, label: {
                                                                    
                                                                    
                                                                    if scienceDelete == true {
                                                                        Image(systemName: "bookmark")
                                                                            .foregroundColor(.white)
                                                                    } else {
                                                                        Image(systemName: scienceSucessfully ? "bookmark.fill" : "bookmark")
                                                                            .foregroundColor(.white)
                                                                    }
                                                                })
                                                                .alert(isPresented: $scienceAlert) {
                                                                    if scienceSucessfully {
                                                                                       Alert(title: Text("Bookmark Added"), message: Text("View bookmarks in the homepage under bookmarks"), dismissButton: .default(Text("Dismiss")))
                                                                    } else {
                                                                                       Alert(title: Text("Bookmark Already Exists"), message: Text("This bookmark is already in your list."), dismissButton: .default(Text("Dismiss")))
                                                                    }
                                                                }
                                                            }
                                                            
                                                            
                                                            
                                                            VStack {
                                                                Text("\(i.date)")
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
                                                        
                                                        
                                                        Spacer()
                                                        Spacer()
                                                        
                                                        
                                                    }
                                                    
                                                    VStack {
                                                        Text("\(i.title)")
                                                            .bold()
                                                            .font(.title)
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                        
                                                        //                                    .padding()
                                                        
                                                        
                                                        Text("By: \(i.authors)")
                                                            .foregroundColor(.gray)
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                        //                                .padding()
                                                        
                                                        Text("Description: ")
                                                            .foregroundColor(.primary)
                                                            .bold()
                                                            .offset(y: 20)
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                        
                                                        
                                                        
                                                        Text("\(i.desc)")
                                                            .foregroundColor(.primary)
                                                            .offset(y: 20)
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                        
                                                        
                                                        if i.desc.isEmpty {
                                                            Text("No decription could be found")
                                                                .padding()
                                                            
                                                        }
                                                        //
                                                        
                                                    }
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .padding()
                                                    .offset(y: -250)
                                                    //                            .background(
                                                    //                                    LinearGradient(colors: [Color("Aquamarine").opacity(0.75), Color("Ocean").opacity(0.75)], startPoint: .top, endPoint: .bottom)
                                                    //                            )
                                                    
                                                }
                                            }
                                        }, label: {
                                            HStack {
                                                if i.imurl != "" {
                                                    WebImage(url: URL(string: i.imurl)!)
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 150, height: 150)
                                                    
                                                    //                                            .cornerRadius(10)
                                                } else {
                                                    Image(systemName: "book.fill")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 150, height: 150)
                                                }
                                            }
                                        })
                                    }
                                    //                            .listRowBackground( LinearGradient(colors: [Color("Aquamarine").opacity(0.75), Color("Ocean").opacity(0.75)], startPoint: .top, endPoint: .bottom))
                                }
                                .frame(height: 200)
                                .padding(.horizontal)
                               
                            }
                            
                        }
                        
                        VStack {
                            Text("English Textbooks")
                                .foregroundColor(.primary)
                                .bold()
                                .padding()
                                .font(.title3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                         
                            
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(englishtextbookdata.data) { i in
                                        
                                        NavigationLink(destination: {
                                            ScrollView(.vertical) {
                                                  VStack {
                                                    VStack {
                                                        
                                                        
                                                        if i.imurl != "" {
                                                            WebImage(url: URL(string: i.imurl)!).resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .frame(width: 200, height: 300)
                                                                .padding()
                                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                                .offset(y: 60)
                                                            
                                                        } else {
                                                            Image(systemName: "book.pages.fill")
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .frame(width: 200, height: 300)
                                                                .padding()
                                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                                .offset(y: 60)
                                                            
                                                        }
                                                        
                                                        
                                                        VStack {
                                                            VStack {
                                                                Text("\(i.page)")
                                                                    .bold()
                                                                
                                                                Text("Pages")
                                                                    .foregroundColor(.gray)
                                                                    .font(.headline)
                                                            }
                                                            .padding()
                                                            
                                                            VStack {
                                                                Text("\(i.language)")
                                                                    .bold()
                                                                
                                                                Text("Langauge")
                                                                    .foregroundColor(.gray)
                                                                    .font(.headline)
                                                            }
                                                            .padding()
                                                            
                                                            
                                                            VStack {
                                                                Button(action: {
                                                                    englishDelete = false
//
                                                                    addBookmark(title: "\(i.title)", author: "\(i.authors)", imurl: "\(i.imurl)")
                                                                                        
                                                                    
                                                                    saveBookmarks()
                                                                    
//
                                                                }, label: {
                                                                    if englishDelete == true {
                                                                        Image(systemName: "bookmark")
                                                                            .foregroundColor(.white)

                                                                    } else {
                                                                        Image(systemName: englishSucessfully ? "bookmark.fill" : "bookmark")
                                                                            .foregroundColor(.white)
                                                                    }
                                                                })
                                                                .alert(isPresented: $englishAlert) {
                                                                    Alert(title: Text("Bookmark Added"), message: Text("View bookmarks in the homepage under bookmarks"), dismissButton: .default(Text("Dismiss")))
                                                                }
                                                            }
                                                            
                                                            
                                                            
                                                            VStack {
                                                                Text("\(i.date)")
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
                                                        
                                                        
                                                        Spacer()
                                                        Spacer()
                                                        
                                                        
                                                    }
                                                    
                                                    VStack {
                                                        Text("\(i.title)")
                                                            .bold()
                                                            .font(.title)
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                        
                                                        //                                    .padding()
                                                        
                                                        
                                                        Text("By: \(i.authors)")
                                                            .foregroundColor(.gray)
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                        //                                .padding()
                                                        
                                                        Text("Description: ")
                                                            .foregroundColor(.primary)
                                                            .bold()
                                                            .offset(y: 20)
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                        
                                                        
                                                        
                                                        Text("\(i.desc)")
                                                            .foregroundColor(.primary)
                                                            .offset(y: 20)
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                        
                                                        
                                                        if i.desc.isEmpty {
                                                            Text("No decription could be found")
                                                                .padding()
                                                            
                                                        }
                                                        //
                                                        
                                                    }
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .padding()
                                                    .offset(y: -250)
                                                    //                            .background(
                                                    //                                    LinearGradient(colors: [Color("Aquamarine").opacity(0.75), Color("Ocean").opacity(0.75)], startPoint: .top, endPoint: .bottom)
                                                    //                            )
                                                    
                                                }
                                            }
                                        }, label: {
                                            HStack {
                                                if i.imurl != "" {
                                                    WebImage(url: URL(string: i.imurl)!)
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 150, height: 150)
                                                    
                                                    //                                            .cornerRadius(10)
                                                } else {
                                                    Image(systemName: "book.fill")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 150, height: 150)
                                                }
                                            }
                                        })
                                    }
                                    //                            .listRowBackground( LinearGradient(colors: [Color("Aquamarine").opacity(0.75), Color("Ocean").opacity(0.75)], startPoint: .top, endPoint: .bottom))
                                }
                                .frame(height: 200)
                                .padding(.horizontal)
                               
                            }
                            
                        }

                        VStack {
                            Text("Art Textbooks")
                                .foregroundColor(.primary)
                                .bold()
                                .padding()
                                .font(.title3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                         
                            
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(arttextbookdata.data) { i in
                                        
                                        NavigationLink(destination: {
                                            ScrollView(.vertical) {
                                                  VStack {
                                                    VStack {
                                                        
                                                        
                                                        if i.imurl != "" {
                                                            WebImage(url: URL(string: i.imurl)!).resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .frame(width: 200, height: 300)
                                                                .padding()
                                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                                .offset(y: 60)
                                                            
                                                        } else {
                                                            Image(systemName: "book.pages.fill")
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .frame(width: 200, height: 300)
                                                                .padding()
                                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                                .offset(y: 60)
                                                            
                                                        }
                                                        
                                                        
                                                        VStack {
                                                            VStack {
                                                                Text("\(i.page)")
                                                                    .bold()
                                                                
                                                                Text("Pages")
                                                                    .foregroundColor(.gray)
                                                                    .font(.headline)
                                                            }
                                                            .padding()
                                                            
                                                            VStack {
                                                                Text("\(i.language)")
                                                                    .bold()
                                                                
                                                                Text("Langauge")
                                                                    .foregroundColor(.gray)
                                                                    .font(.headline)
                                                            }
                                                            .padding()
                                                            
                                                            
                                                            VStack {
                                                                Button(action: {
//
                                                                    
                                                                    self.bm.append(bookmarkItem(title: "\(i.title)", author: "\(i.authors)", imurl: "\(i.imurl)", timestamp: Date()))
                                                                    artSucessfully = true
                                                                    artAlert = true
                                                                    saveBookmarks()
                                                                    
//
                                                                }, label: {
                                                                    if artDelete == true {
                                                                        Image(systemName: "bookmark")
                                                                            .foregroundColor(.white)
                                                                        
                                                                    } else {
                                                                        Image(systemName: artSucessfully ? "bookmark.fill" : "bookmark")
                                                                            .foregroundColor(.white)
                                                                    }
                                                                })
                                                                .alert(isPresented: $artAlert) {
                                                                    Alert(title: Text("Bookmark Added"), message: Text("View bookmarks in the homepage under bookmarks"), dismissButton: .default(Text("Dismiss")))
                                                                }
                                                            }
                                                            
                                                            
                                                            
                                                            VStack {
                                                                Text("\(i.date)")
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
                                                        
                                                        
                                                        Spacer()
                                                        Spacer()
                                                        
                                                        
                                                    }
                                                    
                                                    VStack {
                                                        Text("\(i.title)")
                                                            .bold()
                                                            .font(.title)
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                        
                                                        //                                    .padding()
                                                        
                                                        
                                                        Text("By: \(i.authors)")
                                                            .foregroundColor(.gray)
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                        //                                .padding()
                                                        
                                                        Text("Description: ")
                                                            .foregroundColor(.primary)
                                                            .bold()
                                                            .offset(y: 20)
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                        
                                                        
                                                        
                                                        Text("\(i.desc)")
                                                            .foregroundColor(.primary)
                                                            .offset(y: 20)
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                        
                                                        
                                                        if i.desc.isEmpty {
                                                            Text("No decription could be found")
                                                                .padding()
                                                            
                                                        }
                                                        //
                                                        
                                                    }
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .padding()
                                                    .offset(y: -250)
                                                    //                            .background(
                                                    //                                    LinearGradient(colors: [Color("Aquamarine").opacity(0.75), Color("Ocean").opacity(0.75)], startPoint: .top, endPoint: .bottom)
                                                    //                            )
                                                    
                                                }
                                            }
                                        }, label: {
                                            HStack {
                                                if i.imurl != "" {
                                                    WebImage(url: URL(string: i.imurl)!)
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 150, height: 150)
                                                    
                                                    //                                            .cornerRadius(10)
                                                } else {
                                                    Image(systemName: "book.fill")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 150, height: 150)
                                                }
                                            }
                                        })
                                    }
                                    //                            .listRowBackground( LinearGradient(colors: [Color("Aquamarine").opacity(0.75), Color("Ocean").opacity(0.75)], startPoint: .top, endPoint: .bottom))
                                }
                                .frame(height: 200)
                                .padding(.horizontal)
                               
                            }
                            
                        }
                        
                        VStack {
                             Text("History Textbooks")
                                 .foregroundColor(.primary)
                                 .bold()
                                 .padding()
                                 .font(.title3)
                                 .frame(maxWidth: .infinity, alignment: .leading)
                             
                          
                             
                             ScrollView(.horizontal) {
                                 HStack {
                                     ForEach(historytextbookdata.data) { i in
                                         
                                         NavigationLink(destination: {
                                             ScrollView(.vertical) {
                                                   VStack {
                                                     VStack {
                                                         
                                                         
                                                         if i.imurl != "" {
                                                             WebImage(url: URL(string: i.imurl)!).resizable()
                                                                 .aspectRatio(contentMode: .fit)
                                                                 .frame(width: 200, height: 300)
                                                                 .padding()
                                                                 .frame(maxWidth: .infinity, alignment: .leading)
                                                                 .offset(y: 60)
                                                             
                                                         } else {
                                                             Image(systemName: "book.pages.fill")
                                                                 .resizable()
                                                                 .aspectRatio(contentMode: .fit)
                                                                 .frame(width: 200, height: 300)
                                                                 .padding()
                                                                 .frame(maxWidth: .infinity, alignment: .leading)
                                                                 .offset(y: 60)
                                                             
                                                         }
                                                         
                                                         
                                                         VStack {
                                                             VStack {
                                                                 Text("\(i.page)")
                                                                     .bold()
                                                                 
                                                                 Text("Pages")
                                                                     .foregroundColor(.gray)
                                                                     .font(.headline)
                                                             }
                                                             .padding()
                                                             
                                                             VStack {
                                                                 Text("\(i.language)")
                                                                     .bold()
                                                                 
                                                                 Text("Langauge")
                                                                     .foregroundColor(.gray)
                                                                     .font(.headline)
                                                             }
                                                             .padding()
                                                             
                                                             
                                                             VStack {
                                                                 Button(action: {
 //
                                                                     
                                                                     self.bm.append(bookmarkItem(title: "\(i.title)", author: "\(i.authors)", imurl: "\(i.imurl)", timestamp: Date()))
                                                                     historySucessfully = true
                                                                     historyAlert = true
                                                                     saveBookmarks()
                                                                     
 //
                                                                 }, label: {
                                                                     if historyDelete == true {
                                                                         Image(systemName: "bookmark")
                                                                             .foregroundColor(.white)

                                                                     } else {
                                                                         Image(systemName: historySucessfully ? "bookmark.fill" : "bookmark")
                                                                             .foregroundColor(.white)
                                                                     }
                                                                 })
                                                                 .alert(isPresented: $historyAlert) {
                                                                     Alert(title: Text("Bookmark Added"), message: Text("View bookmarks in the homepage under bookmarks"), dismissButton: .default(Text("Dismiss")))
                                                                 }
                                                             }
                                                             
                                                             
                                                             
                                                             VStack {
                                                                 Text("\(i.date)")
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
                                                         
                                                         
                                                         Spacer()
                                                         Spacer()
                                                         
                                                         
                                                     }
                                                     
                                                     VStack {
                                                         Text("\(i.title)")
                                                             .bold()
                                                             .font(.title)
                                                             .frame(maxWidth: .infinity, alignment: .leading)
                                                         
                                                         //                                    .padding()
                                                         
                                                         
                                                         Text("By: \(i.authors)")
                                                             .foregroundColor(.gray)
                                                             .frame(maxWidth: .infinity, alignment: .leading)
                                                         //                                .padding()
                                                         
                                                         Text("Description: ")
                                                             .foregroundColor(.primary)
                                                             .bold()
                                                             .offset(y: 20)
                                                             .frame(maxWidth: .infinity, alignment: .leading)
                                                         
                                                         
                                                         
                                                         Text("\(i.desc)")
                                                             .foregroundColor(.primary)
                                                             .offset(y: 20)
                                                             .frame(maxWidth: .infinity, alignment: .leading)
                                                         
                                                         
                                                         if i.desc.isEmpty {
                                                             Text("No decription could be found")
                                                                 .padding()
                                                             
                                                         }
                                                         //
                                                         
                                                     }
                                                     .frame(maxWidth: .infinity, alignment: .leading)
                                                     .padding()
                                                     .offset(y: -250)
                                                     //                            .background(
                                                     //                                    LinearGradient(colors: [Color("Aquamarine").opacity(0.75), Color("Ocean").opacity(0.75)], startPoint: .top, endPoint: .bottom)
                                                     //                            )
                                                     
                                                 }
                                             }
                                         }, label: {
                                             HStack {
                                                 if i.imurl != "" {
                                                     WebImage(url: URL(string: i.imurl)!)
                                                         .resizable()
                                                         .aspectRatio(contentMode: .fit)
                                                         .frame(width: 150, height: 150)
                                                     
                                                     //                                            .cornerRadius(10)
                                                 } else {
                                                     Image(systemName: "book.fill")
                                                         .resizable()
                                                         .aspectRatio(contentMode: .fit)
                                                         .frame(width: 150, height: 150)
                                                 }
                                             }
                                         })
                                     }
                                     //                            .listRowBackground( LinearGradient(colors: [Color("Aquamarine").opacity(0.75), Color("Ocean").opacity(0.75)], startPoint: .top, endPoint: .bottom))
                                 }
                                 .frame(height: 200)
                                 .padding(.horizontal)
                                
                             }
                             
                         }
                        
                        Text("Opps it looks like you reach the end.")
                            .foregroundColor(.white)
                            .bold()
                        Text("Dont worry we  have \(mathtextbookdata.numberOfMathBooksAvailable() +   sciencetextbookdata.numberOfScienceBooksAvailable() +  englishtextbookdata.numberOfEnglishBooksAvailable() + arttextbookdata.numberOfArtBooksAvailable() +   historytextbookdata.numberOfHistoryBooksAvailable()) books... and counting!")
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                }
                .background(
                    LinearGradient(colors: [Color("Aquamarine").opacity(0.75), Color("Ocean").opacity(0.75)], startPoint: .top, endPoint: .bottom)
                )
            }
        } else if UIDevice.current.userInterfaceIdiom == .pad {
          
            NavigationView {
                VStack {
                    VStack {
                        Text("Hi, Student!")
                            .foregroundColor(.primary)
                            .bold()
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        Text("Find your next textbook here")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    
                    
                    VStack {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(subjects, id: \.self) { sub in
                                    NavigationLink(destination: {
                                        ContentView()
                                    }, label: {
                                        Text(sub)
                                            .padding()
                                            .foregroundColor(.primary)
                                    })
                                    
                                    .background(.ultraThickMaterial)
                                    .cornerRadius(15)
                                }
                            }
                        }
                    }
                    .padding()
                    
                    
                    
                    
                    ScrollView(.vertical) {
                        
                        VStack {
                            Text("Math Textbooks")
                                .foregroundColor(.primary)
                                .bold()
                                .padding()
                                .font(.title3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            
                            
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(mathtextbookdata.data) { i in
                                        
                                        HStack {
                                            if i.imurl != "" {
                                                WebImage(url: URL(string: i.imurl)!)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 200, height: 200)
                                                
                                                //                                            .cornerRadius(10)
                                            } else {
                                                Image(systemName: "book.fill")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 200, height: 200)
                                            }
                                        }
                                    }
                                    //                            .listRowBackground( LinearGradient(colors: [Color("Aquamarine").opacity(0.75), Color("Ocean").opacity(0.75)], startPoint: .top, endPoint: .bottom))
                                }
                                .frame(height: 200)
                                .padding(.horizontal)
                                
                            }
                            
                        }
                        
                        VStack {
                            Text("Science Textbooks")
                                .foregroundColor(.primary)
                                .bold()
                                .padding()
                                .font(.title3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            
                            
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(sciencetextbookdata.data) { i in
                                        
                                        HStack {
                                            if i.imurl != "" {
                                                WebImage(url: URL(string: i.imurl)!)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 200, height: 200)
                                                
                                                //                                            .cornerRadius(10)
                                            } else {
                                                Image(systemName: "book.fill")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 200, height: 200)
                                            }
                                        }
                                    }
                                    //                            .listRowBackground( LinearGradient(colors: [Color("Aquamarine").opacity(0.75), Color("Ocean").opacity(0.75)], startPoint: .top, endPoint: .bottom))
                                }
                                .frame(height: 200)
                                .padding(.horizontal)
                                
                            }
                            
                        }
                        
                        VStack {
                            Text("English Textbooks")
                                .foregroundColor(.primary)
                                .bold()
                                .padding()
                                .font(.title3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            
                            
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(englishtextbookdata.data) { i in
                                        
                                        HStack {
                                            if i.imurl != "" {
                                                WebImage(url: URL(string: i.imurl)!)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 200, height: 200)
                                                
                                                //                                            .cornerRadius(10)
                                            } else {
                                                Image(systemName: "book.fill")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 200, height: 200)
                                            }
                                        }
                                    }
                                    //                            .listRowBackground( LinearGradient(colors: [Color("Aquamarine").opacity(0.75), Color("Ocean").opacity(0.75)], startPoint: .top, endPoint: .bottom))
                                }
                                .frame(height: 200)
                                .padding(.horizontal)
                                
                            }
                            
                        }
                        
                        VStack {
                            Text("Art Textbooks")
                                .foregroundColor(.primary)
                                .bold()
                                .padding()
                                .font(.title3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            
                            
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(arttextbookdata.data) { i in
                                        
                                        HStack {
                                            if i.imurl != "" {
                                                WebImage(url: URL(string: i.imurl)!)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 200, height: 200)
                                                
                                                //                                            .cornerRadius(10)
                                            } else {
                                                Image(systemName: "book.fill")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 200, height: 200)
                                            }
                                        }
                                    }
                                    //                            .listRowBackground( LinearGradient(colors: [Color("Aquamarine").opacity(0.75), Color("Ocean").opacity(0.75)], startPoint: .top, endPoint: .bottom))
                                }
                                .frame(height: 200)
                                .padding(.horizontal)
                                
                            }
                            
                        }
                        
                        VStack {
                            Text("History Textbooks")
                                .foregroundColor(.primary)
                                .bold()
                                .padding()
                                .font(.title3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            
                            
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(historytextbookdata.data) { i in
                                        
                                        HStack {
                                            if i.imurl != "" {
                                                WebImage(url: URL(string: i.imurl)!)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 200, height: 200)
                                                
                                                //                                            .cornerRadius(10)
                                            } else {
                                                Image(systemName: "book.fill")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 200, height: 200)
                                            }
                                        }
                                    }
                                    //                            .listRowBackground( LinearGradient(colors: [Color("Aquamarine").opacity(0.75), Color("Ocean").opacity(0.75)], startPoint: .top, endPoint: .bottom))
                                }
                                .frame(height: 200)
                                .padding(.horizontal)
                                
                            }
                            
                        }
                        
                        
                        
                        
                        Text("Opps it looks like you reach the end.")
                            .foregroundColor(.white)
                            .bold()
                        Text("Dont worry we  have \(mathtextbookdata.numberOfMathBooksAvailable() +   sciencetextbookdata.numberOfScienceBooksAvailable() +  englishtextbookdata.numberOfEnglishBooksAvailable() + arttextbookdata.numberOfArtBooksAvailable() +   historytextbookdata.numberOfHistoryBooksAvailable()) books... and counting!")
                            .foregroundColor(.gray)
                    }
                    //                .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                }
                .background(
                    LinearGradient(colors: [Color("Aquamarine").opacity(0.75), Color("Ocean").opacity(0.75)], startPoint: .top, endPoint: .bottom)
                )
                
            }
           
        }
        
        
        
       
    }
    
    func addBookmark(title: String, author: String, imurl: String) {
           let newBookmark = bookmarkItem(title: title, author: author, imurl: imurl, timestamp: Date())
           if !bm.contains(where: { $0.title == newBookmark.title && $0.author == newBookmark.author }) {
               bm.append(newBookmark)
               saveBookmarks()
               isSuccesfully = true
               englishSucessfully = true
               artSucessfully = true
               historySucessfully = true
           } else {
               isSuccesfully = false
               englishSucessfully = false
               artSucessfully = false
               historySucessfully = false
           }
           bookAler = true
           scienceAlert = true
           englishAlert = true
           artAlert = true
           historyAlert = true
           
       }
    
    
    func removeBookmark(_ bookmark: bookmarkItem) {
        if let index = bm.firstIndex(where: { $0.id == bookmark.id }) {
            bm.remove(at: index)
            saveBookmarks()
        }
    }
    
    func saveBookmarks() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(bm) {
            UserDefaults.standard.set(encoded, forKey: "bookmarks")
        } else {
            print("DEBUG: Error encoding bookmarks data: ")
        }
    }
    
    func loadBookmarks() {
            if let data = UserDefaults.standard.data(forKey: "bookmarks") {
                let decoder = JSONDecoder()
                do {
                    let decoded = try decoder.decode([bookmarkItem].self, from: data)
                    bm = decoded
                } catch {
                    print("Error decoding bookmarks data: \(error)")
                }
            } else {
                print("No bookmarks data found in UserDefaults")
            }
    }

    
   
}



#Preview("English") {
    HomePage()
//        .modelContainer(for: bookmarkItem.self)
      
        
}

#Preview("German") {
    HomePage()
        .environment(\.locale, Locale(identifier: "DE"))
//        .modelContainer(for: bookmarkItem.self)
       
}


//MARK: BookMarks View

struct BookCell: View {
    
    let bookmark: bookmarkItem
    
    var body: some View {
        
        HStack {
            Text(bookmark.title)
            Spacer()
            Text(bookmark.author)
        }
    }
}

struct RoundedGradientText: View {
    var text: String
    let gradientColors: [Color] = [
                                                        .red,
                                                        .green,
                                                        .yellow,
                                                        .blue,
                                                        .purple,
                                                        .pink,
                                                        .cyan,
                                                        .indigo,
                                                        .mint,
                                                        .orange,
                                                        .teal
                                                    
                                                    
                                                    ]
    
    
   

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(10)
            .frame(width: 190, height: 70)
    }
}

#Preview("Gradient") {
    RoundedGradientText(text: "Math")
}

struct AddBookMark: View {
    @Environment(\.dismiss) private var dismiss
    
    
    @Binding var bm: [bookmarkItem]
    
    @State private var name: String = ""
    @State private var date: Date = .now
    @State private var author: String = ""
    
    func addBook() {
        self.bm.append(bookmarkItem(title: name, author: author, imurl: "", timestamp: date))
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Book Name", text: $name)
                DatePicker("Date", selection: $date, displayedComponents: .date)
                TextField("Author", text: $author)
            }
            .navigationTitle("New Bookmark")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        let book = bookmarkItem(title: name, author: author, imurl: "", timestamp: date)
                        self.addBook()
                        self.name = book.title
                        self.author = book.author
                        
                        
                     
                        dismiss()
                    }
                }
            }
        }
    }
}

//MARK: Google Book API


struct Textbook: Identifiable {
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


class FindMathTextbook: ObservableObject {
    @Published var data = [Textbook]()
    
    
    init() {
        
        
     
        let url = "https://www.googleapis.com/books/v1/volumes?q=calculus"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { (data, _, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            //
            
            let json = try! JSON(data: data!)
            
            let items = json["items"].array!
            
            for i in items {
                
                let id = i["id"].stringValue
                
                let title = i["volumeInfo"]["title"].stringValue
                //
//                let authors = i["volumeInfo"]["authors"].stringValue
                //
                let authors = i["volumeInfo"]["authors"].arrayValue.map { $0.stringValue }
                //
                ////                    let authors = i["volumeInfo"]["authors"].array
                //
                var author = ""
                
                for j in authors {
                    author += "\(j)"
                }
                
                let description = i["volumeInfo"]["description"].stringValue
                //
                let imurl = i["volumeInfo"]["imageLinks"]["thumbnail"].stringValue
                
                let url1 = i["webReaderLink"].stringValue
                
                let pubdate = i["volumeInfo"]["publishedDate"].stringValue
                
                let formattedDate = self.formatDate(pubdate)
                
                let subject = i["volumeInfo"]["categories"].stringValue
                
                let pages = i["volumeInfo"]["pageCount"].stringValue
                
                let lang = i["volumeInfo"]["language"].stringValue
                
                DispatchQueue.main.async {
                    //                                    self.data.append(Textbook(id: id, title: title, authors: author, desc: description, imurl: imurl, url: url1, date: formattedDate, subject: subject, page: pages, language: lang))
                    
                    self.data.append(Textbook(id: id, title: title, authors: author, desc: description, imurl: imurl, url: url1, date: formattedDate, subject: subject, page: pages, language: lang))
                }
            }
            
        }
        .resume()
    }
    
    func numberOfMathBooksAvailable() -> Int {
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


class FindScienceTextbook: ObservableObject {
    @Published var data = [Textbook]()
    
    
    init() {
        
        
     
        let url = "https://www.googleapis.com/books/v1/volumes?q=science"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { (data, _, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            //
            
            let json = try! JSON(data: data!)
            
            if let items = json["items"].array {
                
                for i in items {
                    
                    let id = i["id"].stringValue
                    
                    let title = i["volumeInfo"]["title"].stringValue
                    //
    //                let authors = i["volumeInfo"]["authors"].stringValue
                    //
                    let authors = i["volumeInfo"]["authors"].arrayValue.map { $0.stringValue }
                    //
                    ////                    let authors = i["volumeInfo"]["authors"].array
                    //
                    var author = ""
                    
                    for j in authors {
                        author += "\(j)"
                    }
                    
                    let description = i["volumeInfo"]["description"].stringValue
                    //
                    let imurl = i["volumeInfo"]["imageLinks"]["thumbnail"].stringValue
                    
                    let url1 = i["webReaderLink"].stringValue
                                        
                    let pubdate = i["volumeInfo"]["publishedDate"].stringValue
                                        
                    let formattedDate = self.formatDate(pubdate)
                                        
                    let subject = i["volumeInfo"]["categories"].stringValue
                                        
                    let pages = i["volumeInfo"]["pageCount"].stringValue
                                        
                    let lang = i["volumeInfo"]["language"].stringValue
                    
                    DispatchQueue.main.async {
                        //                                    self.data.append(Textbook(id: id, title: title, authors: author, desc: description, imurl: imurl, url: url1, date: formattedDate, subject: subject, page: pages, language: lang))
                        
                        self.data.append(Textbook(id: id, title: title, authors: author, desc: description, imurl: imurl, url: url1, date: formattedDate, subject: subject, page: pages, language: lang))
                    }
                }
            } else {
                print("Error: 'items' array is nil or not found in JSON")
            }
            
           
            
        }
        .resume()
    }
    
    func numberOfScienceBooksAvailable() -> Int {
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

class FindEnglishTextbook: ObservableObject {
    @Published var data = [Textbook]()
    
    
    init() {
        
        
     
        let url = "https://www.googleapis.com/books/v1/volumes?q=english"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { (data, _, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            //
            
            let json = try! JSON(data: data!)
            
            let items = json["items"].array!
            
            for i in items {
                
                let id = i["id"].stringValue
                
                let title = i["volumeInfo"]["title"].stringValue
                //
//                let authors = i["volumeInfo"]["authors"].stringValue
                //
                let authors = i["volumeInfo"]["authors"].arrayValue.map { $0.stringValue }
                //
                ////                    let authors = i["volumeInfo"]["authors"].array
                //
                var author = ""
                
                for j in authors {
                    author += "\(j)"
                }
                
                let description = i["volumeInfo"]["description"].stringValue
                //
                let imurl = i["volumeInfo"]["imageLinks"]["thumbnail"].stringValue
                
                let url1 = i["webReaderLink"].stringValue
                                    
                let pubdate = i["volumeInfo"]["publishedDate"].stringValue
                                    
                let formattedDate = self.formatDate(pubdate)
                                    
                let subject = i["volumeInfo"]["categories"].stringValue
                                    
                let pages = i["volumeInfo"]["pageCount"].stringValue
                                    
                let lang = i["volumeInfo"]["language"].stringValue
                
                DispatchQueue.main.async {
                    //                                    self.data.append(Textbook(id: id, title: title, authors: author, desc: description, imurl: imurl, url: url1, date: formattedDate, subject: subject, page: pages, language: lang))
                    
                    self.data.append(Textbook(id: id, title: title, authors: author, desc: description, imurl: imurl, url: url1, date: formattedDate, subject: subject, page: pages, language: lang))
                }
            }
            
        }
        .resume()
    }
    
    func numberOfEnglishBooksAvailable() -> Int {
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

class FindArtTextbook: ObservableObject {
    @Published var data = [Textbook]()
    
    
    init() {
        
        
     
        let url = "https://www.googleapis.com/books/v1/volumes?q=art"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { (data, _, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            //
            
            let json = try! JSON(data: data!)
            
            let items = json["items"].array!
            
            for i in items {
                
                let id = i["id"].stringValue
                
                let title = i["volumeInfo"]["title"].stringValue
                //
//                let authors = i["volumeInfo"]["authors"].stringValue
                //
                let authors = i["volumeInfo"]["authors"].arrayValue.map { $0.stringValue }
                //
                ////                    let authors = i["volumeInfo"]["authors"].array
                //
                var author = ""
                
                for j in authors {
                    author += "\(j)"
                }
                
                let description = i["volumeInfo"]["description"].stringValue
                //
                let imurl = i["volumeInfo"]["imageLinks"]["thumbnail"].stringValue
                
                let url1 = i["webReaderLink"].stringValue
                                    
                let pubdate = i["volumeInfo"]["publishedDate"].stringValue
                                    
                let formattedDate = self.formatDate(pubdate)
                                    
                let subject = i["volumeInfo"]["categories"].stringValue
                                    
                let pages = i["volumeInfo"]["pageCount"].stringValue
                                    
                let lang = i["volumeInfo"]["language"].stringValue
                
                DispatchQueue.main.async {
                    //                                    self.data.append(Textbook(id: id, title: title, authors: author, desc: description, imurl: imurl, url: url1, date: formattedDate, subject: subject, page: pages, language: lang))
                    
                    self.data.append(Textbook(id: id, title: title, authors: author, desc: description, imurl: imurl, url: url1, date: formattedDate, subject: subject, page: pages, language: lang))
                }
            }
            
        }
        .resume()
    }
    
    func numberOfArtBooksAvailable() -> Int {
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

class FindHistoryTextbook: ObservableObject {
    @Published var data = [Textbook]()
    
    
    init() {
        
        
     
        let url = "https://www.googleapis.com/books/v1/volumes?q=history"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { (data, _, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            //
            
            let json = try! JSON(data: data!)
            
            let items = json["items"].array!
            
            for i in items {
                
                let id = i["id"].stringValue
                
                let title = i["volumeInfo"]["title"].stringValue
                //
//                let authors = i["volumeInfo"]["authors"].stringValue
                //
                let authors = i["volumeInfo"]["authors"].arrayValue.map { $0.stringValue }
                //
                ////                    let authors = i["volumeInfo"]["authors"].array
                //
                var author = ""
                
                for j in authors {
                    author += "\(j)"
                }
                
                let description = i["volumeInfo"]["description"].stringValue
                //
                let imurl = i["volumeInfo"]["imageLinks"]["thumbnail"].stringValue
                
                let url1 = i["webReaderLink"].stringValue
                                    
                let pubdate = i["volumeInfo"]["publishedDate"].stringValue
                                    
                let formattedDate = self.formatDate(pubdate)
                                    
                let subject = i["volumeInfo"]["categories"].stringValue
                                    
                let pages = i["volumeInfo"]["pageCount"].stringValue
                                    
                let lang = i["volumeInfo"]["language"].stringValue
                
                DispatchQueue.main.async {
                    //                                    self.data.append(Textbook(id: id, title: title, authors: author, desc: description, imurl: imurl, url: url1, date: formattedDate, subject: subject, page: pages, language: lang))
                    
                    self.data.append(Textbook(id: id, title: title, authors: author, desc: description, imurl: imurl, url: url1, date: formattedDate, subject: subject, page: pages, language: lang))
                }
            }
            
        }
        .resume()
    }
    
    func numberOfHistoryBooksAvailable() -> Int {
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


