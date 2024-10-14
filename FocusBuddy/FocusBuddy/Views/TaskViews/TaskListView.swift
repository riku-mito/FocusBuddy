//
//  TaskListView.swift
//  FocusBuddy
//
//  Created by Riku Mito on 2023/06/01.
//
//  ====== Credits: =====
//  Swift code referenced from "Create a custom data model for Todo items in SwiftUI | Todo List #2" by @Swiftful Thinking https://www.youtube.com/watch?v=SMt4_WUdKag&t
//  "Add a ViewModel with @EnvironmentObject in SwiftUI | Todo List #3" by @Swiftful Thinking https://www.youtube.com/watch?v=nwpmWu1SP1k
//  Save and persist data with UserDefaults | Todo List #4 by @Swiftful Thinking https://www.youtube.com/watch?v=1QOLiELlpGk&t=0s
//  =====================

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var taskViewModel: TaskViewModel
    
    private let textColor = AppColor.text
    
    var body: some View {
        NavigationView {
            ZStack {
                if taskViewModel.tasks.isEmpty {
                    Text("No tasks to do! 🥳")
                } else {
                    List {
                        ForEach(taskViewModel.tasks) { task in
                            NavigationLink(destination: TaskDetailView(task: task)) {
                                TaskRowView(task: task)
                                    .onTapGesture {
                                        taskViewModel.updateTask(task: task)
                                    }
                            }
                        }
                        .onDelete(perform: taskViewModel.deleteTask)
                        .onMove(perform: taskViewModel.moveTask)
                    }
                }
            }
            .navigationBarTitle("To Do List 📝", displayMode: .inline)
            .navigationBarItems(leading: EditButton(), trailing: NavigationLink("Add", destination: AddTaskView()))
        }
    }

}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TaskListView()
        }
        .environmentObject(TaskViewModel())
    }
}


