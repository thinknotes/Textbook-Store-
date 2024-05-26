//
//  PDFViewer.swift
//  TextbookStore
//
//  Created by Avi Bansal on 5/25/24.
//

import Foundation
import PDFKit
import SwiftUI

struct PDFKitView: UIViewRepresentable {
    let pdfDoc: PDFDocument
    
    init(pdfDoc: PDFDocument) {
        self.pdfDoc = pdfDoc
    }
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = pdfDoc
        pdfView.autoScales = true
        
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        uiView.document = pdfDoc
    }
}
