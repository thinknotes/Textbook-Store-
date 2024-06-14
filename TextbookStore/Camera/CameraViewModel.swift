//
//  CameraViewModel.swift
//  TextbookStore
//
//  Created by Avi Bansal on 6/13/24.
//

import Foundation
import SwiftUI
import VisionKit
import AVKit


enum ScanType: String {
    case text, textbook, barcode
}

enum DataScannerAccessStatusType {
    case notDetermined
    case cameraAccessNotGranted
    case cameraNotAvailable
    case scannerAvailable
    case scannerNotAvailable
}

@MainActor
final class CameraViewModel: ObservableObject {
    
    @Published var recognizedItems: [RecognizedItem] = []
    @Published var scanType: ScanType = .barcode
    @Published var dataScannerAccessStatus: DataScannerAccessStatusType = .notDetermined
    @Published var textContentType: DataScannerViewController.TextContentType?
    @Published var recoginzesMultipleItems = true
    
     var recoginzedDataType: DataScannerViewController.RecognizedDataType {
        scanType == .barcode ? .barcode() : .text(textContentType: textContentType)
    }
    
    var headerText: String {
        if recognizedItems.isEmpty {
            return "Scanning \(scanType.rawValue)"
        } else {
            return "Recognized \(recognizedItems.count) item(s)"
        }
    }
    
    var dataScannerViewId: Int {
        var haser = Hasher()
        haser.combine(scanType)
        haser.combine(recoginzesMultipleItems)
        if let textContentType {
            haser.combine(textContentType)
        }
        
        return haser.finalize()
    }
    
    private var isScannerAvailable: Bool {
        DataScannerViewController.isAvailable && DataScannerViewController.isSupported
    }
    
    func requestDataScannerAccessStatus() async {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            dataScannerAccessStatus = .cameraNotAvailable
            return
        }
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            
            
            
        case .restricted, .denied:
            dataScannerAccessStatus = .cameraAccessNotGranted
        case .authorized:
            dataScannerAccessStatus = isScannerAvailable ? .scannerAvailable : .scannerNotAvailable
        case .notDetermined:
            let granted = await AVCaptureDevice.requestAccess(for: .video)
            if granted {
                dataScannerAccessStatus = isScannerAvailable ? .scannerAvailable : .scannerNotAvailable
            } else {
                dataScannerAccessStatus = .cameraAccessNotGranted
            }
        default: break
        }
        
    }
}
