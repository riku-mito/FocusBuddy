//
//  TimerViewModel.swift
//  FocusBuddy
//
//  Created by Riku Mito on 2023/06/01.
//
//  ====== Credits: =====
//  Swift code referenced from "Build a SwiftUI Custom Countdown Timer app for iOS 15 (2022)" by @Indently https://www.youtube.com/watch?v=NAsQCNpodPI
//  =====================

import Foundation

class TimerViewModel: ObservableObject {
    @Published var isActive: Bool = false // If the timer is active or not
    @Published var showingAlert: Bool = false // If the alert is showing or not
    @Published var time: String = "25:00" // Timer text that shows on UI
    @Published var minutes: Float = 25.0 { // Timer text from selection
        didSet {
            self.time = "\(Int(minutes)):00"
        }}
        
    private var initialTime = 0
    private var endDate = Date()
    
    func start(minutes: Float) {
        self.initialTime = Int(minutes)
        self.endDate = Date()
        self.isActive = true
        self.endDate = Calendar.current.date(byAdding: .minute, value: Int(minutes), to: endDate)!
    }
    
    func reset() {
        self.minutes = Float(initialTime)
        self.isActive = false
        self.time = "\(Int(minutes)):00"
    }
    
    func updateCountdown() {
        guard isActive else { return }
        
        let now = Date()
        let diff = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
        
        if diff <= 0 {
            self.isActive = false
            self.time = "0:00"
            self.showingAlert = true
            return
        }
        
        let date = Date(timeIntervalSince1970: diff)
        let calendar = Calendar.current
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        
        self.minutes = Float(minutes)
        self.time = String(format: "%d:%02d", minutes, seconds)
    }
}
