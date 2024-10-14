//
//  MainView.swift
//  FocusBuddy
//
//  Created by Riku Mito on 2023/06/01.
//

import SwiftUI

struct MainView: View {
    var body: some View {
            TabView { // TabView shows icon on bottom of screen
                TaskListView() // Shows tasks screen
                    .tabItem {
                        Label("To Do", systemImage: "checklist")
                    }
                TimerView() // Shows timer screen
                    .tabItem {
                        Label("Timer", systemImage: "timer")
                    }
            }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(TaskViewModel())
    }
}
