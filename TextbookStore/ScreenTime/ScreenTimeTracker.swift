//
//  ScreenTimeTracker.swift
//  TextbookStore
//
//  Created by Avi Bansal on 7/10/24.
//

import Foundation
import SwiftUI
import Combine


class ScreenTimeTracker: ObservableObject {
    @Published var timeSpent: TimeInterval = 0  // Time spent in seconds
    
    private var timer: Timer?
    private var startTime: Date?
    private let timeSpentKey = "timeSpent"  // Key for UserDefaults
    
    init() {
        loadTimeSpent()
        startTracking()
    }
    
    func startTracking() {
        startTime = Date()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.updateTimeSpent()
        }
    }
    
    func stopTracking() {
        timer?.invalidate()
        timer = nil
    }
    
    func updateTimeSpent() {
        guard let startTime = startTime else { return }
        timeSpent += Date().timeIntervalSince(startTime)
        self.startTime = Date()
        saveTimeSpent()
    }
    
    func resetTimeSpent() {
        timeSpent = 0
        saveTimeSpent()
    }
    
    func formattedTime() -> String {
        let hours = Int(timeSpent) / 3600
        let minutes = (Int(timeSpent) % 3600) / 60
        let seconds = Int(timeSpent) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    func saveTimeSpent() {
        UserDefaults.standard.set(timeSpent, forKey: timeSpentKey)
    }
    
    func loadTimeSpent() {
        timeSpent = UserDefaults.standard.double(forKey: timeSpentKey)
    }
}

