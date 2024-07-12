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
    
    @State private var authors = [String]()
    
    let allSubjets = [
        
         "Math",
         "Science",
         "English",
         "Art - Humanity",
         "History",
         "Other"
    
    ]
    
    @State var selectedSubject = "Other"
    
    var body: some View {
        
        ScrollView(.vertical) {
            VStack {
                Text("Add a new book")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                
              
                
                
                VStack {
                    
                    Section("Title") {
                        
                        TextField("Book title", text: $fileName)
                            .padding()
                            .textFieldStyle(.roundedBorder)
                    }
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    
                    Section("URL") {
                        
                        HStack {
                            
                            
                            
                            TextField("URL:", text: $linkText)
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
                    }
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                 
                    
                    Section("Author") {
                            
                        ForEach(0..<authors.count, id: \.self) { index in
                                             HStack {
                                                 Button(action: { authors.remove(at: index) }) {
                                                     Image(systemName: "minus.circle.fill")
                                                         .foregroundColor(.red)
                                                         .padding(.horizontal)
                                                 }
                                                 TextField("Author", text: getBinding(forIndex: index))
                                             }
                                         }
                        
                                         Button(action: { authors.append("") }) {
                                             HStack {
                                                 Image(systemName: "plus.circle.fill")
                                                     .foregroundColor(.green)
                                                     .padding(.horizontal)
                                                 Text("Add another author")
                                             }
                                         }
                                     
                             
                            
                        }
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.vertical)
                    
                    
                    Section("Subject") {
                        
                        Picker("Choose a subject", selection: $selectedSubject) {
                            ForEach(allSubjets, id: \.self) { subject in
                                Text("\(subject)")
                                
                            }
                        }
                            
                        
                    }
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    
                    
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
                            Text("Add")
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
            LinearGradient(colors: [Color("Aquamarine").opacity(0.75), Color("Ocean").opacity(0.75)], startPoint: .top, endPoint: .bottom)
        )
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
    
    func getBinding(forIndex index: Int) -> Binding<String> {
            return Binding<String>(get: { authors[index] },
                                   set: { authors[index] = $0 })
        }
}

#Preview("English") {
    Add()
}

#Preview("German") {
    Add()
        .environment(\.locale, Locale(identifier: "DE"))
}
