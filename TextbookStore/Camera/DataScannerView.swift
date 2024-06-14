//
//  DataScannerView.swift
//  TextbookStore
//
//  Created by Avi Bansal on 6/13/24.
//

import Foundation
import SwiftUI
import VisionKit



struct DataScannerView: UIViewControllerRepresentable {
    @Binding var recoginzedItems: [RecognizedItem]
    let recognizedDataType: DataScannerViewController.RecognizedDataType
    let recongizesMultipleItems: Bool
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let vc = DataScannerViewController(recognizedDataTypes: [recognizedDataType], qualityLevel: .balanced, recognizesMultipleItems: recongizesMultipleItems, isGuidanceEnabled: true, isHighlightingEnabled: true)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        uiViewController.delegate = context.coordinator
        try? uiViewController.startScanning()
    }
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(recoginzedItems: $recoginzedItems)
    }
    
    static func dismantleUIViewController(_ uiViewController: DataScannerViewController, coordinator: Coordinator) {
        uiViewController.stopScanning()
    }

    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        
        @Binding var recoginzedItems: [RecognizedItem]
        
        init(recoginzedItems: Binding<[RecognizedItem]>) {
            self._recoginzedItems = recoginzedItems
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            print("DEBUG: didTapOn \(item)")
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            recoginzedItems.append(contentsOf: addedItems)
            
            print("DEBUG: didAddItems \(addedItems)")
        }
        
        
        func dataScanner(_ dataScanner: DataScannerViewController, didRemove removedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            self.recoginzedItems = recoginzedItems.filter { item in
                !removedItems.contains(where: {$0.id == item.id})
            }
            print("DEBUG: didRemoveItems \(removedItems)")
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, becameUnavailableWithError error: DataScannerViewController.ScanningUnavailable) {
            print("DEBUG: became unavaiable with error \(error.localizedDescription)")
        }
    }
}
