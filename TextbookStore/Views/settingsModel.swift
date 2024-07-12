//
//  settingsModel.swift
//  TextbookStore
//
//  Created by Avi Bansal on 7/3/24.
//

import Foundation
import SwiftUI

class settingModel: ObservableObject {
    
    @Published var selectedDate: Date = Date()
    @Published var isUSFormat: Bool = false 
    
    @Published var isSub: Bool = false
    
    @Published var isStudyMode: Bool = false
    
    
    
    func formattedDate() -> String {
            if isUSFormat {
                return selectedDate.formatted(.dateTime.month().day().year())
            } else {
                return selectedDate.formatted(.dateTime.day().month().year())
            }
        }
        
        func toggleFormat() {
            isUSFormat.toggle()
        }
    
}
