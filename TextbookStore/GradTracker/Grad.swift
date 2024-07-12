//
//  Grad.swift
//  TextbookStore
//
//  Created by Avi Bansal on 6/21/24.
//

import SwiftUI

struct Grad: View {
    
    
  
    
    //name
    @AppStorage("name") var name: String = ""
    @AppStorage("onboard") var onboard: Bool = false
    @AppStorage("major") var major: String = ""
    
    var body: some View {
        NavigationView {
            
            Dash(name: name.self, major: major.self)
              
//            if onboard == true {
//                Welcome()
//            } else {
//                Dash(name: name, major: major)
//            }
               
            }
        }
        
    }


#Preview {
    Grad()
        
}


struct Welcome: View {
    
    @AppStorage("major") var major: String = ""
    
    var majorList: [String] = [
        "Business Administration",
        "Computer Science",
        "Nursing",
        "Criminal Justice",
        "Engineering Technology",
        "Graphic Design",
        "Early Childhood Education",
        "Accounting",
        "Information Technology",
        "Health Sciences",
        "Liberal Arts",
        "Hospitality Management",
        "Mechanical Engineering",
        "Psychology",
        "Sociology",
        "Biology",
        "Environmental Science",
        "Digital Media",
        "Automotive Technology",
        "Paralegal Studies",
        "Other"
    ]
    
    // Define the range of years for the picker
    let startYear: Int = 2020
    let endYear: Int = 2100
        
        // State variable to hold selected year
   /* @State private var selectedYear: Int = 2024*/ // Default selection
    
    
    //Major Grid
    let columns = Array(repeating: GridItem(.fixed(100)), count: 3)
    
    @State var isSelected: Bool = false
    
    @State private var selectedIdx: Int? = nil
    @State var onBoarding: Bool = false
    
//    @AppStorage("selectedIdx") private var selectedIdx: Int? = nil
    
//    @AppStorage("selectedYear") private var selectedYear: Int?
    
    var body: some View {
        NavigationView {
            VStack {
                
                Header()
                
                //            Spacer()
                
                //            Text("")
                //            Text("")
                //            Text("")
                
                HStack {
                    Text("I am studying: ")
                        .bold()
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    
                }
                
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(0..<majorList.count, id: \.self) { index in
                            Text(majorList[index])
                                .foregroundColor(selectedIdx == index ? .white : .black)
                                .frame(height: 50)
                                .font(.caption)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .background(selectedIdx == index ? Color.blue : Color.white)
                                .cornerRadius(10)
                                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
                                .onTapGesture {
                                    if selectedIdx == index {
                                        selectedIdx = nil // Deselect if already selected
                                        isSelected = false
                                    } else {
                                        selectedIdx = index // Select the tapped item
                                        isSelected = true
                                        onBoarding = true
                                        major = majorList[index]
                                        print("DEBUG: User Major Selected is \(major)")
                                    }
                                }
                        }
                        
                    }
                    
                    
                    //
                }
                
                
                if isSelected == true {
                    VStack {
                        NavigationLink(destination: {
                            year().navigationBarHidden(true)
                        }, label: {
                            Text("Next")
                                .frame(width: 200, height: 50)
                                .background(.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        })
                    }
                } else {
                    Text("")
                }
                
        
            }
        }
        
        Spacer()
    }
}
    
    #Preview("Welcome") {
        Welcome()
    }



struct year: View {
    //Year Grid
    
    @AppStorage("selectedYear") private var selectedYear: Int?
//    @State private var selectedYear: Int? = nil // Track selected year
    let years = Array(2024...2034) // Example range of years
    let ycolumns = [GridItem(.adaptive(minimum: 100))]
    @State private var ySelected: Bool = false
    @State var onBoarding: Bool = false
    var body: some View {
        NavigationView {
            VStack {
                Header()
                
                HStack {
                    Text("I am graduting: ")
                        .bold()
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    
                }
                
                ScrollView {
                    LazyVGrid(columns: ycolumns, spacing: 16) {
                        ForEach(years, id: \.self) { year in
                            Text("\(year)")
                                .foregroundColor(selectedYear == year ? .white : .black)
                                .frame(height: 50)
                                .font(.caption)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .background(selectedYear == year ? Color.blue : Color.white)
                                .cornerRadius(10)
                                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
                                .onTapGesture {
                                    if selectedYear == year {
                                        selectedYear = nil // Deselect if already selected
                                        ySelected = false
                                    } else {
                                        selectedYear = year // Select the tapped year
                                        ySelected = true
                                        onBoarding = true
                                    }
                                }
                        }
                    }
                    .padding()
                }
                
                if ySelected == true {
                    VStack {
                        NavigationLink(destination: {
                            Name().navigationBarBackButtonHidden(true)
                        }, label: {
                            Text("Next")
                                .frame(width: 200, height: 50)
                                .background(.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        })
                    }
                } else {
                    Text("")
                }
            }
        }
    }
}

#Preview("year") {
    year()
}

struct Name: View {
    
    //name
    @State var username: [String] = [""]
    
    @AppStorage("name") var name: String = ""
    @AppStorage("major") var major: String = ""
    
    @State var onBoarding: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                


                        VStack {
                            Header()
                            
                            Spacer()
                            VStack {
                                Text("What is your name?")
                                    .bold()
                                    .font(.title)
                                
                                TextField("Name", text: $name)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                //                                    .padding()
                                    .padding(.horizontal)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .border(.gray)
                                
                                Button(action: {
                                    username.append(name)
                                    onBoarding = true
                                }, label: {
                                    if username.isEmpty {
                                        Text("Name was not saved")
                                    }
                                    Text("Save Name")
                                })
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .center)
                            
                            NavigationLink(destination: {
                                NavigationView {
                                    VStack {
                                        VStack {
                                            Text("Grad Tracker")
                                                .bold()
                                                .font(.title)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .padding()
                                            
                                            Text("Powered by AI")
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .padding(.horizontal)
                                                .foregroundColor(.gray)
                                        }
                                        
                                        Spacer()
                                        
                                        Text("Welcome \(name)")
                                            .bold()
                                            .font(.title)
                                        
                                        Text("Where glad to have you here. With Grad Tracker you can find textbooks based on your major with the help of AI.")
                                            .foregroundColor(.gray)
                                            .padding()
                                        
                                     
                                        
                                        NavigationLink(destination: {
                                            VStack {
                                                Dash(name: name, major: major)

                                            }
                                            .navigationBarBackButtonHidden(true)
                                        }, label: {
                                            
                                             Text("Get Started")
                                                .frame(width: 200, height: 50)
                                                .background(.blue)
                                                .foregroundColor(.white)
                                                .cornerRadius(10)
                                        })
                                        
                                        Spacer()
                                    }
                                    .navigationBarBackButtonHidden(true)
                                }.navigationBarBackButtonHidden(true)
                            }, label: {
                                    Text("Next")
                                        .frame(width: 200, height: 50)
                                        .background(.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                
                                
                                
                            })
                            
                            Spacer()
                          
                        }
                        
                        
                     
                    }.navigationBarBackButtonHidden(true)
                
                
            }
            
            Spacer()
        }
    }
    
        
    


#Preview("Name") {
    Name()
}

struct Header: View {
    var body: some View {
        VStack {
            
            
            HStack {
                Text("Grad Tracker")
                    .bold()
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                Button(action: {
                    
                }, label: {
                    Text("Skip")
                        .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .background(
                                    
                                    Capsule()
                                        .stroke(Color.gray, lineWidth: 1)
                                        .fill(.clear)
                                    
                                
                                )
                                .padding()
                                .frame(height: 40)
                           
                })
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            Text("Powered by AI")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .foregroundColor(.gray)
            
            
        }
    }
}

#Preview("Header") {
    Header()
}

struct Dash: View {
    @State var name: String = ""
    @State var major: String = ""
    

    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    
                    
                    HStack {
                        Text("Grad Tracker")
                            .bold()
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        
                        NavigationLink(destination: { Welcome().navigationBarBackButtonHidden(true)
                            
                        }, label: {
                            Text("Re-Enter Info")
                                .font(.headline)
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                        .background(
                                            
                                            Capsule()
                                                .stroke(Color.gray, lineWidth: 1)
                                                .fill(.clear)
                                            
                                        
                                        )
                                        .padding()
                                        .frame(height: 40)
                                   
                        })
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        
//                        NavigationLink(destination: {
//                            profile(isSub: true, name: name)
//                        }, label: {
//                            CircleView(initials: initialsFrom(name: name))
//                                .padding()
//                        })
//                        
                       
                       
                    }
                    
                    Text("Powered by AI")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .foregroundColor(.gray)
                    
                    
                }
                
                Divider()
                
                Text("Welcom Back, \(name)!")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical)
                    .foregroundColor(.white)
                    .padding()
                    .bold()
                
                
                ScrollView(.horizontal) {
                    VStack {
                        VStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 300, height: 140)
                                .padding()
                            
                            Text("Book Recomandation")
                        }
                    }
                    
//                    
//                    Spacer()
                }
                
                Text("Since Your Are Studying: \(major.description)")
                    .bold()
                
                Spacer()
                
            }
            
           
        }
    }
        }
    


#Preview("Dashboard") {
    Dash(name: "Mark", major: "Computer Science")
}

struct CircleView: View {
    var initials: String
    
    private let colors: [Color] = [.blue, Color("iCloudGreen"), Color("iCloudOrange"), Color("iCloudPink"), .indigo, .purple,Color("Ocean"), Color("Aquamarine")]
    
    
    
    var body: some View {
        let randomColor = colors.randomElement() ?? .blue
        
        
     
            
    
            Circle()
                .fill(randomColor)
                .frame(width: 50, height: 50)
                .overlay(
                    Text(initials)
                        .font(.headline)
                        .foregroundColor(.white)
                )
        
        
       
    }
}





extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}




func initialsFrom(name: String) -> String {
       guard !name.isEmpty else { return "" }
       
       let components = name.components(separatedBy: " ")
       let initials = components.reduce("") { $0 + String($1.first ?? Character("")) }
       
       return initials
   }



