//
//  Item.swift
//  TextbookStore
//
//  Created by Avi Bansal on 5/19/24.
//

import Foundation
import SwiftData
import SwiftUI




struct Item: Identifiable {
     var id = UUID()
     var title: String
     var subject: String
     var authors: [String]
     var pdf: String
     var image: Image
    
    
    
}



//Search Token Code:

final class Book: Identifiable {
    var id = UUID()
    var title: String
    var subject: String
    var authors: [String]
    var pdf: String
    var image: Image
    
    init(id: UUID = UUID(), title: String, subject: String, authors: [String], pdf: String, image: Image) {
        self.id = id
        self.title = title
        self.subject = subject
        self.authors = authors
        self.pdf = pdf
        self.image = image
    }
    
}

struct Token: Identifiable {
    var id: String { title }
    var title: String
}


