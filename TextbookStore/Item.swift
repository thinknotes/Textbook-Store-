//
//  Item.swift
//  TextbookStore
//
//  Created by Avi Bansal on 5/19/24.
//

import Foundation
import SwiftData

@Model
final class Item {
   
    var title: String
    var subject: String
    var edition: Int
    var authors: [String]
    
    init(title: String, subject: String, edition: Int, authors: [String]) {
        self.title = title
        self.subject = subject
        self.edition = edition
        self.authors = authors
    }
}

//Search Token Code:

struct Book: Identifiable {
    var id = UUID()
    var title: String
    var subject: String
    var edition: Int
    var authors: [String]
}

struct Token: Identifiable {
    var id: String { title }
    var title: String
}


