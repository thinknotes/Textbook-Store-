//
//  Home.swift
//  TextbookStore
//
//  Created by Avi Bansal on 5/25/24.
//

import SwiftUI


enum Tabs: String, CaseIterable {
    case house
    case book
    case plus
    case dollarsign
    case gear
}

enum Pages: Hashable {
    case home
    case book
    case plus
    case dollarsign
    case settings
}

struct Tabbar: View {
    
    @Binding var selectedTab: Tabs
    
    private var fillImage: String {
        if (selectedTab == .house || selectedTab == .book) {
            selectedTab.rawValue + ".fill"
        }
        
        return selectedTab.rawValue
    }
    
    private var tabColor: Color {
        switch selectedTab {
            
        case .house:
            return .accentColor
        case .book:
            return .primary
        case .plus:
            return .red
        case .dollarsign:
            return .green
        
        case .gear:
            return .orange
        }
    }
    
    //Ipad var
    
    @State private var page: Pages  = .home
    
    var body: some View {
        
     
            VStack {
                HStack {
                    ForEach(Tabs.allCases, id: \.rawValue) { tab in
                        Spacer()
                        Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                            .scaleEffect(tab == selectedTab ? 1.25 : 1.0)
                            .foregroundColor(selectedTab == tab ? tabColor : .gray)
                            .font(.system(size: 22))
                            .onTapGesture {
                                withAnimation(.easeIn(duration: 0.1)) {
                                    selectedTab = tab
                                }
                            }
                        Spacer()
                    }
                    
                }
                .frame(width: nil, height: 60)
                .background(.thinMaterial)
                .cornerRadius(10)
                .padding()
            }
        
//        } else if UIDevice.current.userInterfaceIdiom == .pad {
//            
//           NavigationSplitView(sidebar: {
//               VStack {
//                   ForEach(Tabs.allCases, id: \.rawValue) { tab in
////                       Spacer()
//                       Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
//                           .scaleEffect(tab == selectedTab ? 1.25 : 1.0)
//                           .foregroundColor(selectedTab == tab ? tabColor : .gray)
//                           .font(.system(size: 22))
//                           .onTapGesture {
//                               withAnimation(.easeIn(duration: 0.1)) {
//                                   selectedTab = tab
//                               }
//                           }
//                           .padding()
//                          
////                       Spacer()
//                   }
//               }
////               
////               .frame(width: nil, height: 60)
//               .background(.thinMaterial)
//               .cornerRadius(10)
//               .padding()
//           }, detail: {
//               
//           })
////                TabView(selection: $page) {
////                                        Tab("Home", systemName: "", value: .home) {
////                                            HomePage()
////                                        }
////                    
////                                        Tab("Book", systemName: "", value: .book) {
////                                            ContentView()
////                                        }
////                    
////                                        Tab("Add", systemName: "", value: .plus) {
////                                            Add()
////                                        }
////                    
////                                        Tab("Pay", systemName: "", value: .dollarsign) {
////                                            Text("Pay")
////                                        }
////                }
////                .tabViewStyle(.page)
////            
//                
//        }
    }
}

#Preview {
    Tabbar(selectedTab: .constant(.house))
}
