//
//  Task.swift
//  FocusBuddy
//
//  Created by Riku Mito on 2023/06/01.
//
//  ====== Credits: =====
//  Swift code referenced from "Create a custom data model for Todo items in SwiftUI | Todo List #2" by @Swiftful Thinking https://www.youtube.com/watch?v=SMt4_WUdKag&t
//  "Add a ViewModel with @EnvironmentObject in SwiftUI | Todo List #3" by @Swiftful Thinking https://www.youtube.com/watch?v=nwpmWu1SP1k
//  Save and persist data with UserDefaults | Todo List #4 by @Swiftful Thinking https://www.youtube.com/watch?v=1QOLiELlpGk&t=0s
//  =====================

import Foundation

// Immutable struct
struct Task: Identifiable, Codable { // Identifiable -> Tasks can be identified uniquely (must have an id), Codable -> encode/decode Tasks into data
    
    // All 'let' items, not 'var' because there is a risk of the variables being changed directly from other files
    let id: String // task.id is unique for each task
    let title: String // Main info of a task
    let isCompleted: Bool // Array of subtasks
    let priority: Priority // Level of importance
    let dueDate: Date
    let description: String // String description of task
    
    enum Priority: String, CaseIterable, Codable {
        case high // High priority case
        case medium // Medium priority case
        case low  // Low priority case
        case none // No priority case
    }
    
    // It can initialize a Task with an id, or without an id which will create one
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool, priority: Priority, dueDate: Date, description: String) {
        self.id = UUID().uuidString // If the task has no id, it can initialize by using a random id string
        self.title = title
        self.isCompleted = isCompleted
        self.priority = priority
        self.dueDate = dueDate
        self.description = description
    }
    
    func updatedTask() -> Task { // The struct can only be updated through this function
        return Task(id: id, title: title, isCompleted: !isCompleted, priority: priority, dueDate: dueDate, description: description)
    }
    
    func getDaysLeft(_ due: Date) -> Int {
        let  userLocale = Locale.autoupdatingCurrent
        var gregorianCalendar = Calendar(identifier: .gregorian)
        gregorianCalendar.locale = userLocale
        
        let daysBetweenAnnouncements = gregorianCalendar.dateComponents(
          [.day],
          from: Date.now,
          to: due
        )
        return daysBetweenAnnouncements.day ?? 0
    }
}


//struct MainInformation { // Key components of a task
//    var name: String // Title of task
//    var isDone: Bool // Check if task if done
//    //var dueDate: Date // Date task is due
//    var priority: Priority // Level of importance
//    var subject: String // English, Math, History, etc.
//    var description: String // Additional notes
//
//}
//
//struct Subtask { // Key components of a subtask
//    var name: String // Title of subtask
//    var isDone: Bool // Check if subtask is done
//}
//
//extension Task {
//    static let exampleTasks: [Task] = [
//        Task(mainInformation: MainInformation(name: "Finish chemistry worksheet",
//                                              isDone: false,
//                                              priority: .high,
//                                              subject: "Science",
//                                              description: "pg.50-60"),
//             subtasks: [
//                Subtask(name: "Book 1", isDone: false),
//                Subtask(name: "Book 2", isDone: false)
//             ]
//            ),
//
//        Task(mainInformation: MainInformation(name: "Watch coding lecture",
//                                              isDone: false,
//                                              priority: .medium,
//                                              subject: "Coding",
//                                              description: ""),
//             subtasks: [
//                Subtask(name: "Lecture 1", isDone: false)
//             ]
//            )
//    ]
//}
