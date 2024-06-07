//
//  Add.swift
//  TextbookStore
//
//  Created by Avi Bansal on 5/25/24.
//

import SwiftUI

struct Add: View {
    @State private var fileName: String = ""
    @State private var linkText: String = ""
    @State private var isLinkValid: Bool = false
    @State private var linkAlert: Bool = false
    var body: some View {
        
        ScrollView(.vertical) {
            VStack {
                Text("Add new files")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                
                Text("The file which you are uploading should be less than 2MB.")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .font(.system(size: 13))
                
                
                VStack {
                    
                    
                    ZStack {
            
                        
                        
                        
                        PDFView()
                        
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.clear)
                            .frame(height: 100)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [5, 5]))
                                    .foregroundColor(.gray)
                            )
                            .padding()
                        
                        
                        
                        
                    }
                    
                    Text("Name your File")
                        .foregroundColor(.gray)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    
                    TextField("Book title", text: $fileName)
                        .padding()
                        .textFieldStyle(.roundedBorder)
                    
                    HStack {
                        Rectangle()
                            .frame(width: 30, height: 1)
                            .foregroundColor(.gray)
                        
                        Text("OR")
                            .foregroundColor(.gray)
                        
                        
                        Rectangle()
                            .frame(width: 30, height: 1)
                            .foregroundColor(.gray)
                        
                        
                        
                    }
                    
                    Text("Import from URL")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    
                    
                    
                    HStack {
                        
                        TextField("Enter Link", text: $linkText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        Button(action: {
                            verifyLink()
                        }, label: {
                            Text("Add")
                                .padding()
                                .foregroundColor(.primary)
                        })
                        .alert(isPresented: $linkAlert) {
                            Alert(title: Text("Error"), message: Text("The link provided does not match required type: URL"), dismissButton: .default(Text("Ok")))
                                
                        }
                      
                        
                        
                        
                        if isLinkValid {
                            Image(systemName: "checkmark")
                                .foregroundColor(.green)
                                .padding()
                        } else {
                            Image(systemName: "xmark")
                                .foregroundColor(.red)
                                .padding()
                        }
                        
                    }
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Still need help?")
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .font(.headline)
                            .foregroundColor(.primary)
                    })
                    
                    
                    
                    HStack {
                        Button(action: {
                            
                        }, label: {
                            Text("Cancel")
                            
                                .foregroundColor(.primary)
                                .frame(width: 150, height: 50)
                        })
                        
                        
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }, label: {
                            Text("Upload")
                                .foregroundColor(.primary)
                                .frame(width: 150, height: 50)
                            
                        })
                        .buttonStyle(.borderedProminent)
                        
                    }
                    .padding()
                }
            }
        }
        .background(
            LinearGradient(colors: [Color("Lavender"), Color("Powder blue")], startPoint: .top, endPoint: .bottom)
        )
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
    
    private func verifyLink() {
           // Basic validation, you can customize it based on your requirements
           if let url = URL(string: linkText), UIApplication.shared.canOpenURL(url) {
               isLinkValid = true
           } else {
               linkAlert = true
               isLinkValid = false
           }
       }
}

#Preview("English") {
    Add()
}

#Preview("German") {
    Add()
        .environment(\.locale, Locale(identifier: "DE"))
}
