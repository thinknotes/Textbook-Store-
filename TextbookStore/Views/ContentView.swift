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
    
    @State var isActive: Bool = false
    
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
    
    //Camera
 
    @State private var viewCamera: Bool = false
    
    
    //Ipad  Version Variables
    
    @State private var searchbar: String = ""
    @State private var isExpanable: Bool = false
    @State private var isClear: Bool = false
    
    @State private var searchOptions = ["All", "Files", "People"]
    @State private var selectedOption = ""
    
    @State private var viewBook: Bool = false
    
    
    
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
        
        
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            NavigationSplitView {
                HStack {
                    Text("Database Search")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .bold()
                    
                    Text("# of Books: ")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .font(.caption)
                }
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
                                    //                                    .padding()
                                    
                                    ForEach(item.authors, id: \.self) { authors in
                                        Text("By: \(authors)")
                                            .foregroundColor(.gray)
                                        //                                        .padding()
                                        
                                    }
                                    .blur(radius: isActive ? 20 : 0)
                                    
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    //                                .padding()
                                    
                                    Text("Description: ")
                                        .foregroundColor(.primary)
                                        .bold()
                                        .offset(y: 20)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .blur(radius: isActive ? 20 : 0)
                                    
                                    
                                    if bookDesc.isEmpty {
                                        Text("No decription could be found")
                                            .padding()
                                            .blur(radius: isActive ? 20 : 0)
                                    }
                                    
                                    
                                    if isActive {
                                        CustomDialog(isActive: $isActive, title: "Are you sure?", message: "By agreeing to download, you waive your rights and know you may be breaking the law", buttonTitle1: "I Understand", buttonTitle2: "Go Back To Safety", action: {}, action1: {})
                                            .offset(y: -200)
                                    }
                                    
                                    
                                    //                                    .offset(y: 20)
                                    
                                    
                                    Button(action: {
                                        isActive = true
                                    }, label: {
                                        Text("Download \(item.title)")
                                    })
                                    .buttonStyle(BorderedButtonStyle())
                                    .blur(radius: isActive ? 20 : 0)
                                    //
                                    
                                    
                                    
                                    
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .offset(y: -250)
                                //                            .offset(y: isActive ? -250 : 0)
                                
                                
                                
                                
                                
                                
                                
                                Spacer()
                            }
                           
                            .background(
                                LinearGradient(colors: [Color("Aquamarine").opacity(0.75), Color("Ocean").opacity(0.75)], startPoint: .top, endPoint: .bottom)
                            )
                            
                            
                        } label: {
                            VStack {
                                HStack {
                                    Image(systemName: "book.pages.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40, height: 40)
                                        .background(.gray)
                                        .clipShape(Circle())
                                  
                                    
                                    
                                    
                                    
                                    VStack {
                                        Text("\(item.title)")
                                            .bold()
                                            .font(.headline)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        ForEach(item.authors, id: \.self) { authors in
                                            Text("By: \(authors)")
                                                .foregroundColor(.gray)
                                                .font(.caption)
                                            //                                        .padding()
                                            
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        
                                        
                                        
                                        
                                        
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    
                                    
                                    
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                
                                HStack {
                                    Text("\(item.subject)")
                                        .frame(width: 60, height: 20)
                                        .frame(alignment: .leading)
                                        .bold()
                                        .font(.caption)
                                        .background(Capsule()
                                            .fill(Color.blue))
                                    
                                    
                                    Text("PDF")
                                        .frame(width: 60, height: 20)
                                        .frame(alignment: .leading)
                                        .bold()
                                        .font(.caption)
                                        .background(Capsule()
                                            .fill(Color.green))
                                    
                                    Spacer()
                                    
                                    
                                    Text("1 day Ago")
                                        .foregroundColor(.gray)
                                        .frame(width: 80, height: 20)
                                        .frame(alignment: .leading)
                                        .bold()
                                        .font(.caption)
                                        .background(Capsule()
                                            .fill(Color.white))
                                    
                                }
                                .offset(y: 20)
                             
                                
                                
                            }
                            .frame(height: 100)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
//                        .background(
//                            LinearGradient(colors: [Color("Aquamarine").opacity(0.75), Color("Ocean").opacity(0.75)], startPoint: .top, endPoint: .bottom)
//                        )
                        
                        
                    }
                
                   
                  
                    
                    
                    
                    
                    
                }
                
                
                
                
                
                .toolbar {
                    
                    ToolbarItem {
                        HStack {
                            Picker("Choose a subject", selection: $selectedSubject) {
                                ForEach(allSubjets, id: \.self) { subject in
                                    Text("\(subject)")
                                    
                                }
                            }
                            
                            Button(action: {
                                
                            }, label: {
                                Image(systemName: "slider.horizontal.3")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                            })
                            
                        }
                        
                        
                        
                    }
                    
                }
                
                .searchable(text: $search, tokens: $currentTokens, prompt: Text("Type to filter")) { token in
                    Text(token.title)
                    
                }
                
            } detail: {
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
                        
                        
                 
                        
                        TextField("Search textbook, authors, people", text: $searchbar)
                            .foregroundColor(.primary)
                            .onChange(of: searchbar) { searchText in
                                    isExpanable = true
                                    isClear = true
                                }
                           
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
                            ForEach(searchResults) { item in
                                HStack {
                                    Image(systemName: "book.pages.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(.black)
                                    
                                    
                                    
                                    VStack {
                                        Text("\(item.title)")
                                            .bold()
                                            .font(.headline)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .foregroundColor(.black)
                                        //                                        .padding()
                                        
                                        ForEach(item.authors, id: \.self) { authors in
                                            Text("By: \(authors)")
                                                .foregroundColor(.gray)
                                                .font(.caption)
                                            //                                        .padding()
                                            
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        
                                        
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
                                        .offset(x: -180)
                                        
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
                                                                
                                                                ForEach(item.authors, id: \.self) { authors in
                                                                    Text("By: \(authors)")
                                                                        .foregroundColor(.gray)
                                                                    //                                        .padding()
                                                                    
                                                                }
                                                                .blur(radius: isActive ? 20 : 0)
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
                                                                
                                                                
                                                                //                                    .offset(y: 20)
                                                                
                                                                VStack {
                                                                    Button(action: {
                                                                        isActive = true
                                                                    }, label: {
                                                                        Text("Download \(item.title)")
                                                                    })
                                                                    .buttonStyle(BorderedButtonStyle())
                                                                    .blur(radius: isActive ? 20 : 0)
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
                        }
                    }
//                    .padding(.horizontal)
                    .offset(x: 250,y: -590)
                    
                }
                
                
//                TextField("Search textbook, authors, people", text: $searchbar)
//                    .frame( alignment: .center)
            }
            .padding()
            
            
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
            return Color.gray
        default:
            return Color.black
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
