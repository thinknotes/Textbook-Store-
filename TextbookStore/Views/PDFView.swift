//
//  PDFView.swift
//  TextbookStore
//
//  Created by Avi Bansal on 6/2/24.
//

import SwiftUI
import QuickLook
import StoreKit

struct PDFView: View {
    @State private var pickFile: Bool = false
    @State private var fileURL: URL?
    @Environment(\.requestReview) var requestReview

    var body: some View {
        Button("Choose File") {
            pickFile.toggle()
        }
        .fileImporter(isPresented: $pickFile, allowedContentTypes: [.mp3, .pdf, .png, .text, .url]) { result in
            switch result {
            case .success(let success):
                fileURL = success.absoluteURL
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            
            
            
        }
        .quickLookPreview($fileURL)
    }
}

#Preview {
    PDFView()
}
