//
//  FocusBuddyApp.swift
//  FocusBuddy
//
//  Created by Riku Mito on 2023/06/01.
//

import SwiftUI

@main
struct FocusBuddyApp: App {
    
    @StateObject var taskViewModel: TaskViewModel = TaskViewModel()
    @StateObject var timerViewModel: TimerViewModel = TimerViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainView()
            }
            .environmentObject(taskViewModel) // All views have access to the taskViewModel
            .environmentObject(timerViewModel) //
        }
    }
}
