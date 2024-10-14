//
//  TaskViewModel.swift
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
import SwiftUI

class TaskViewModel: ObservableObject { // ObservableObject allows instances of this class to be used inside views. When important changes happen the view will reload.
    
    @Published var tasks: [Task] = [] {
        didSet { // any time the tasks array changes, the function gets called (ex. deleteTask(), moveTask(), etc.)
            saveTasks()
        }
    }
    let tasksKey: String = "tasks_list"
    
    init() {
        getTasks()
    }
    
    func getTasks() {
        
        // guard prevents the current scope from continuing if required conditions are not met
        guard
            let data = UserDefaults.standard.data(forKey: tasksKey),
            let savedTasks = try? JSONDecoder().decode([Task].self, from: data)
        else { return }
        
        self.tasks = savedTasks // tasks array will be updated with saved data
    }
    
    // CRUD FUNCTIONS
    // C - Create
    // R - Read
    // U - Update
    // D - Delete
    
    func deleteTask(indexSet: IndexSet) {
        tasks.remove(atOffsets: indexSet)
    }
    
    func moveTask(from: IndexSet, to: Int) {
        tasks.move(fromOffsets: from, toOffset: to)
    }
    
    func addTask(title: String, priority: String, dueDate: Date, description: String) {
        let newTask = Task(title: title, isCompleted: false, priority: Task.Priority(rawValue: priority) ?? .none, dueDate: dueDate, description: description)
        tasks.append(newTask)
    }
    
    func updateTask(task: Task) {
        // Finding the first index where a task in the tasks array has the same id as the id we are looking for
        if let index = tasks.firstIndex(where: { $0.id == task.id }) { // All items are unique
            tasks[index] = task.updatedTask()
        }
    }
    
    func saveTasks() {
        if let encodedData = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encodedData, forKey: tasksKey)
        }
    }
}
