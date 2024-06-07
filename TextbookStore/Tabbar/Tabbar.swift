//
//  Home.swift
//  TextbookStore
//
//  Created by Avi Bansal on 5/25/24.
//

import SwiftUI


enum Tab: String, CaseIterable {
    case house
    case book
    case plus
    case dollarsign
}

struct Tabbar: View {
    
    @Binding var selectedTab: Tab
    
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
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
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
    }
}

#Preview {
    Tabbar(selectedTab: .constant(.house))
}
