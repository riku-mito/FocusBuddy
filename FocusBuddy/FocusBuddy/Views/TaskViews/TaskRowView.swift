//
//  TaskRowView.swift
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

struct TaskRowView: View {
    
    let task: Task
    private let textColor = AppColor.text
    
    var body: some View {
        
            HStack {
                Image(systemName: task.isCompleted ? "checkmark.circle" : "circle")
                    .foregroundColor(task.isCompleted ? Color.accentColor : buttonColor)
                VStack{
                    HStack{
                        Text(task.title)
                            .strikethrough(task.isCompleted ? true : false)
                            .foregroundColor(task.isCompleted ? Color.accentColor : textColor)
                        Spacer()
                    }
                    HStack {
                        switch task.isCompleted {
                        case true:
                            Text("Completed")
                                .font(.system(size: 12))
                                .foregroundColor(Color.accentColor)
                            Spacer()
                        default:
                            switch task.getDaysLeft(task.dueDate) {
                            case 0:
                                Text("DUE TODAY")
                                    .font(.system(size: 12))
                                    .foregroundColor(textColor)
                                Spacer()
                            case 1:
                                Text("DUE TOMORROW")
                                    .font(.system(size: 12))
                                    .foregroundColor(textColor)
                                Spacer()
                            default:
                                Text("Due in \(task.getDaysLeft(task.dueDate)) days")
                                    .font(.system(size: 12))
                                    .foregroundColor(textColor)
                                Spacer()
                            }
                        }
                    }
                }
                .multilineTextAlignment(.leading)
                Spacer()
            }
                .font(.system(size: 20))
                .padding(.vertical, 5)
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

struct TaskRowView_Previews: PreviewProvider {
    
    static var taskExample1 = Task(title: "High priority task", isCompleted: false, priority: .high, dueDate: .now, description: "Test description")
    static var taskExample2 = Task(title: "Medium priority task", isCompleted: false, priority: .medium, dueDate: .now, description: "Test description")
    static var taskExample3 = Task(title: "Low priority task", isCompleted: false, priority: .low, dueDate: .now, description: "Test description")
    static var taskExample4 = Task(title: "No priority task", isCompleted: false, priority: .none, dueDate: .now, description: "Test description")
    static var taskExample5 = Task(title: "Finished task", isCompleted: true, priority: .none, dueDate: .now, description: "Test description")
    
    static var previews: some View {
        Group {
            TaskRowView(task: taskExample1)
            TaskRowView(task: taskExample2)
            TaskRowView(task: taskExample3)
            TaskRowView(task: taskExample4)
            TaskRowView(task: taskExample5)
        }
        .previewLayout(.sizeThatFits)
    }
}
