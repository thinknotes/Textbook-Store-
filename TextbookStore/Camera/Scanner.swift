//
//  Scanner.swift
//  TextbookStore
//
//  Created by Avi Bansal on 6/13/24.
//

import SwiftUI
import VisionKit

struct Scanner: View {
    
    @EnvironmentObject var cameraViewModel: CameraViewModel
    
    private let textContentTypes: [(title: String, textContentType: DataScannerViewController.TextContentType?)] = [
        ("All", .none),
        ("URL", .URL),
        ("Phone", .telephoneNumber),
        ("Email", .emailAddress),
        ("Address", .fullStreetAddress),
        ("Dates",.dateTimeDuration),
        ("Currency", .currency)
            
    ]
    
    var body: some View {
        switch cameraViewModel.dataScannerAccessStatus {
        case .notDetermined:
            Text("Requesting camera access")
        case .cameraAccessNotGranted:
            Text("Please provide access to the camera in the settings")
        case .cameraNotAvailable:
            Text("Your device doesn't have a camera")
        case .scannerAvailable:
            Text("Scanner is available")
        case .scannerNotAvailable:
            Text("Your devices doesnt have support for scanning textbooks with this app")
        }
            
    }
    
    private var mainView: some View {
        VStack {
            DataScannerView(recoginzedItems: $cameraViewModel.recognizedItems, recognizedDataType: cameraViewModel.recoginzedDataType, recongizesMultipleItems: cameraViewModel.recoginzesMultipleItems)
                .background { Color.gray.opacity(0.3)}
                .ignoresSafeArea()
                .id(cameraViewModel.dataScannerViewId)
                .sheet(isPresented: .constant(true), content: {
                    bottomContainerView
                        .background(.ultraThinMaterial)
                        .presentationDetents([.medium, .fraction(0.25)])
                        .presentationDragIndicator(.visible)
                        .interactiveDismissDisabled()
                        .onAppear {
                            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let controller = windowScene.windows.first?.rootViewController?.presentedViewController else {
                                return
                            }
                            controller.view.backgroundColor = .clear
                        }
                })
            
            VStack {
                headerView
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 16) {
                        ForEach(cameraViewModel.recognizedItems) { item in
                            switch item {
                            case .barcode(let barcode):
                                Text(barcode.payloadStringValue ?? "Unkown barcode")
                            case .text(let text):
                                Text(text.transcript)
                            @unknown default:
                                Text("Unkown")
                            }
                        }
                    }
                }
            }
        }
        .onChange(of: cameraViewModel.scanType) { _ in cameraViewModel.recognizedItems = [] }
        .onChange(of: cameraViewModel.textContentType) { _ in cameraViewModel.recognizedItems = []}
        .onChange(of: cameraViewModel.recoginzesMultipleItems) { _ in cameraViewModel.recognizedItems = []}
    }
    
    private var headerView: some View {
        VStack {
            HStack {
                Picker("Scan Type", selection: $cameraViewModel.scanType) {
                    Text("Text").tag(ScanType.text)
                    Text("Textbook").tag(ScanType.textbook)
                    Text("Barcode").tag(ScanType.barcode)
                }
                
                Toggle("Scan multiple", isOn: $cameraViewModel.recoginzesMultipleItems)
            }
            .padding(.top)
            
            if cameraViewModel.scanType == .text {
                Picker("Text content type", selection: $cameraViewModel.textContentType) {
                    ForEach(textContentTypes, id: \.self.textContentType) { option in
                        Text(option.title).tag(option.textContentType)
                    }
                }
            }
            
            Text(cameraViewModel.headerText)
                .padding(.top)
        }
    }
    
    private var bottomContainerView: some View {
        VStack {
            HStack {
                Picker("Scan Type", selection: $cameraViewModel.scanType) {
                    Text("Text").tag(ScanType.text)
                    Text("Textbook").tag(ScanType.textbook)
                    Text("Barcode").tag(ScanType.barcode)
                }
                
                Toggle("Scan multiple", isOn: $cameraViewModel.recoginzesMultipleItems)
            }
            .padding(.top)
            
            if cameraViewModel.scanType == .text {
                Picker("Text content type", selection: $cameraViewModel.textContentType) {
                    ForEach(textContentTypes, id: \.self.textContentType) { option in
                        Text(option.title).tag(option.textContentType)
                    }
                }
            }
            
            Text(cameraViewModel.headerText)
                .padding(.top)
        }
    }
}

#Preview {
    Scanner()
        .environmentObject(CameraViewModel())
     
}
