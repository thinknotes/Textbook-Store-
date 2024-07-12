//
//  books.swift
//  TextbookStore
//
//  Created by Avi Bansal on 6/14/24.
//

import Foundation
import SwiftUI





let books: [Book] = [
    Book(title: "Prinplces of enginer", subject: "Math", authors: ["Sam GoodsBugr"], pdf: "",  imageURL: ""),
    Book(title: "History of the world", subject: "History", authors: ["Leonard Lee"], pdf: "http://www.toomey.org/tutor/text_books/Digital_Logic/Discrete%20Mathematics%20with%20Applications%20-%20Susanna%20S.%20Epp%20(2019).pdf", imageURL: ""),
    Book(title: "Spainsh 101", subject: "Other", authors: ["Maria Gonzulezs"], pdf: "", imageURL: "")

]

func genData() {
   
    
    do {
       let  _ = try JSONEncoder().encode(books)
    } catch {
        print("Error encoding data: \(error.localizedDescription)")
    }
    
    
}
