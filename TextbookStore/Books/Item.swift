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

struct Book: Identifiable, Codable {
    var id = UUID()
    var title: String
    var subject: String
    var authors: [String]
    var pdf: String
    // var image: Image  // Remove this property from Codable
    
    // Use a URL or String for image reference instead
    var imageURL: String
    
    // CodingKeys enum to customize encoding/decoding
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case subject
        case authors
        case pdf
        case imageURL = "image_url"  // Map imageURL to "image_url" in JSON
    }
    
    // Initializer to set all properties
    init(id: UUID = UUID(), title: String, subject: String, authors: [String], pdf: String, imageURL: String) {
        self.id = id
        self.title = title
        self.subject = subject
        self.authors = authors
        self.pdf = pdf
        self.imageURL = imageURL
    }
}

struct Token: Identifiable {
    var id: String { title }
    var title: String
}


