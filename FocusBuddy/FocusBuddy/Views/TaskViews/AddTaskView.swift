//
//  AddTaskView.swift
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

struct AddTaskView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var taskViewModel: TaskViewModel
    @State var textFieldText: String = ""
    @State var selectedPriority = Task.Priority.none
    @State var selectedDate = Date.now
    @State var descriptionFieldText: String = ""
    
    var body: some View {
        Form {
            TextField("Add your task...", text: $textFieldText)
            Picker("Priority", selection: $selectedPriority) {
                ForEach(Task.Priority.allCases, id: \.self) { priority in
                    Text("Priority: \(priority.rawValue.capitalized)")
                }
            }
                .pickerStyle(MenuPickerStyle())
            DatePicker("Due: ", selection: $selectedDate)
                .labelsHidden()
            TextField("Add a description...", text: $descriptionFieldText)
            
            if isValid(){
                HStack {
                    Spacer()
                    Button("Save") {
                        saveButton()
                    }
                    Spacer()
                }
            }
        }
        .navigationTitle("Add a Task 🆕")
    }
    
    func saveButton() {
        taskViewModel.addTask(title: textFieldText, priority: selectedPriority.rawValue, dueDate: selectedDate, description: descriptionFieldText)
        presentationMode.wrappedValue.dismiss()
    }
    
    func isValid() -> Bool {
        return !textFieldText.isEmpty ? true : false
    }

}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddTaskView()
        }
        .environmentObject(TaskViewModel())
    }
}
