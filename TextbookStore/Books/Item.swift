//
//  Item.swift
//  TextbookStore
//
//  Created by Avi Bansal on 5/19/24.
//

import Foundation
import SwiftData
import SwiftUI


protocol LocalizedStringResource {
    func localizedTitle() -> String
    func localizedSubject() -> String
    // Add more localization-related requirements as needed
}

struct Item: Identifiable, LocalizedStringResource {
     var id = UUID()
     var title: String
     var subject: String
     var authors: [String]
     var pdf: String
     var image: Image
    
    
    func localizedTitle() -> String {
            // Implement localization logic for the title
            return NSLocalizedString(title, comment: "")
        }
        
        func localizedSubject() -> String {
            // Implement localization logic for the subject
            return NSLocalizedString(subject, comment: "")
        }
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


