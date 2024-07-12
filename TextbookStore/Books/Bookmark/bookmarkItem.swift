//
//  bookmarkItem.swift
//  TextbookStore
//
//  Created by Avi Bansal on 7/5/24.
//

import Foundation
import SwiftUI
import SwiftData
import Observation


//@Observable class bookmarkItem {
//    var title: String = ""
//    var author: String = ""
//    var imurl: String = ""
//    var timestamp: Date = .now
//    
//    
//    init(title: String, author: String, imurl: String, timestamp: Date) {
//        self.title = title
//        self.author = author
//        self.imurl = imurl
//        self.timestamp = timestamp
//    }
//}


struct bookmarkItem: Identifiable, Codable {
    let title: String
    let author: String
    let imurl: String
    let timestamp: Date
    let id = UUID()
}
