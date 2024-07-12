//
//  TextbookStoreApp.swift
//  TextbookStore
//
//  Created by Avi Bansal on 5/19/24.
//

import SwiftUI
import SwiftData

@main
struct TextbookStoreApp: App {

    @StateObject private var tracker = ScreenTimeTracker()
        
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            Home()
                .environmentObject(tracker)
                .onChange(of: scenePhase) { newPhase in
                                    switch newPhase {
                                    case .active:
                                        tracker.startTracking()
                                    case .background:
                                        tracker.stopTracking()
                                    default:
                                        break
                        }
                    }
               
              
        }
//        .modelContainer(sharedModelContainer)
    }
}
