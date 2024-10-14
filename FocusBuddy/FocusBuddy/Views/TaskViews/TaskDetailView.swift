//
//  TaskDetailView.swift
//  FocusBuddy
//
//  Created by Riku Mito on 2023/06/01.
//

import SwiftUI

struct TaskDetailView: View {
    let task: Task
    private let textColor = AppColor.text
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var taskViewModel: TaskViewModel

    
    var body: some View {
        List {
            HStack {
                Image(systemName: task.isCompleted ? "checkmark.circle" : "circle")
                    .foregroundColor(task.isCompleted ? Color.accentColor : buttonColor)
                Text(task.title)
                    .strikethrough(task.isCompleted ? true : false)
                    .foregroundColor(task.isCompleted ? Color.accentColor : buttonColor)
                    .font(.title)
            }
                .onTapGesture {
                    taskViewModel.updateTask(task: task)
                }
            HStack{
                Text("Due date:")
                Spacer()
                Text(task.dueDate, format: .dateTime.day().month())
                Text(task.dueDate, format: .dateTime.hour().minute())
            }
            HStack{
                Text("Time remaining:")
                Spacer()
                switch task.isCompleted {
                case true:
                    Text("Completed")
                        .foregroundColor(Color.accentColor)
                default:
                    switch task.getDaysLeft(task.dueDate) {
                    case 0:
                        Text("DUE TODAY")
                            .foregroundColor(textColor)
                    case 1:
                        Text("\(task.getDaysLeft(task.dueDate)) day")
                            .foregroundColor(textColor)
                    default:
                        Text("\(task.getDaysLeft(task.dueDate)) days")
                            .foregroundColor(textColor)
                    }
                }
            }
            if task.description.isEmpty {
                Text("No description")
                    .foregroundColor(.gray)
            } else {
                Text(task.description)
                    .font(.system(size: 15))
            }
        }
            .multilineTextAlignment(.leading)
            .font(.system(size: 20))
            .navigationTitle("Your Task 📝")
    }
    
    var buttonColor: Color {
        if task.priority == .high {
            return .red
        } else if task.priority == .medium {
            return .orange
        } else if task.priority == .low {
            return .yellow
        } else {
            return textColor
        }
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var taskExample1 = Task(title: "Test Task", isCompleted: false, priority: .high, dueDate: .now, description: "Test")
    
    static var previews: some View {
        NavigationView{
            TaskDetailView(task: taskExample1)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}
