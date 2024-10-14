# FocusBuddy

FocusBuddy is a simple Task Managing iOS App for ADHD users made with Swift.


## Abstract

FocusBuddy is an iOS task managing app specifically designed to assist individuals with ADHD in organizing and completing their tasks effectively. The app features a user-friendly interface with two primary components: a to-do list maker and a timer.

The to-do list maker allows users to input tasks with varying priorities, categorized as high, medium, low, or no priority. Additionally, users can specify the due date and time for each task, enabling them to track the remaining days until completion. The main page of the app displays a simple list of tasks, accompanied by colored buttons indicating task urgency. Red signifies high priority, orange represents medium priority, yellow denotes low priority, and black indicates no priority. Once a task is completed, users can mark it as done, resulting in a strikethrough effect on the task text, while the text and button color change to green.
Tapping on a task in the list allows users to access task details, including a simple description field for additional notes or reminders. Returning to the main task list, an "add" button facilitates easy inclusion of new tasks, requiring title, priority, and date fields, while the description field remains optional.

The app also includes a timer section featuring a prominent timer that can be set from 1 to 60 minutes in 1-minute intervals. The in-app timer provides a convenient tool for users to time themselves during their tasks without the need to switch applications. Upon completion of the set time, the app generates an alert to notify users that the timer has finished.
This task management app prioritizes simplicity and avoids overwhelming users with unnecessary functions or complex interfaces. Based on the experiences of the developer, who has used various task management apps, the goal is to minimize stress associated with task planning by maintaining a focused and streamlined user experience.


## Code

FocusBuddy consists of the following files:

- Models
  - Task.swift
- Views
  - MainView.swift
  - TimerView.swift
  - TaskListView.swift
  - TaskRowView.swift
  - AddTaskView.swift
  - TaskDetailView.swift
- ViewModels
  - AppColor.swift
  - TimerViewModel.swift
  - TaskViewModel.swift
- FocusBuddyApp.swift

Task.swift is the *model* which consists of the information of a task. The user will create many instances of a task in the app, so the different variables of a task is listed in this file, such as the title, due date, priority level, and details. 

MainView.swift is the main page of the iOS app where all the views come together. This is where I used `TabView` to call and toggle between the TaskListView.swift and TimerView.swift. Adding the TabView caused issues with the NavigationTitle. There was unneeded space above the title so I was able to remove as much as possible, but I was not able to completely remove the space.

TaskListView.swift is the main page of the to-do list where all of the tasks are listed. TaskListView calls for the TaskViewModel to be able to access the items inside. The TaskViewModel variable is looped through and prints out a TaskRowView.swift navigation link for each task. 

TaskRowView.swift is the individual row of the task in TaskListView. This is the design of the each of the rows: the colored button, title, and due date of the task.

AddTaskView.swift is the page to add a new task. This consists of different user inputs that will be saved through the functions in TaskViewModel.swift, 

TaskDetailView.swift is the page for the detailed description of the individual task.

AppColor.swift is the file that saves the universal colors for this app. This page was created to experiment with different color combinations. Originally there were two other colors, but did not work aesthetically with adding the dark mode view for the app. The text and accent color is added through assets and accounts for dark mode. 

TaskViewModel.swift is where all the properties and commands for the task is saved. As mentioned earlier in AddTaskView.swift, this file is responsible of functions such as `deleteTask()` `moveTask()` `addTask()` `updateTask()` and `saveTasks()`, which are CRUD functions: Create, Read, Update, Delete. 

TimerViewModel.swift is similar to TaskViewModel.swift where it consists of all the properties and commands for the timer of the app. This is where it counts down the timer, starts, resets, and posts an alert when the timer is finished.

Within the Task.swift file, I have commented out many lines of code. This is where I was testing out different variables that Task object can have. I tried to implement subjects, however, I was unable to figure out how to add onto a preexisting list of switch cases. Originally I wanted a few subjects such as "English", "Math", "History", "Science" where the user can choose the type of subject the task is, but can also input or delete subjects themselves. Instead of using a switch case, I may need to use an array of strings instead so that the user can easily remove them. 

I also tried to add the subtask struct in this file, but as I was able to initialize the variables, I was unsure how to save the subtasks in the TaskDetailView.swift file. In the future, I want to be able to research and figure out how to tackle this issue and be able to create subtasks within a task.

## References

As mentioned within the code files, the app has referenced some code from:

- "Create a custom data model for Todo items in SwiftUI | Todo List #2" by @Swiftful Thinking https://www.youtube.com/watch?v=SMt4_WUdKag&t
- "Add a ViewModel with @EnvironmentObject in SwiftUI | Todo List #3" by @Swiftful Thinking https://www.youtube.com/watch?v=nwpmWu1SP1k
- "Save and persist data with UserDefaults | Todo List #4" by @Swiftful Thinking https://www.youtube.com/watch?v=1QOLiELlpGk&t
- ["Build a SwiftUI Custom Countdown Timer app for iOS 15 (2022)" by @Indently https://www.youtube.com/watch?v=NAsQCNpodPI

