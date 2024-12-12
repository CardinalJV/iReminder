  //
  //  iReminderApp.swift
  //  iReminder
  //
  //  Created by Jessy Viranaiken on 15/10/2024.
  //

import SwiftUI
import SwiftData

@main
struct iReminderApp: App {
  
  @State private var taskController = TaskController()
  
  var body: some Scene {
    WindowGroup {
      LandingView()
        .environment(taskController)
    }
    .modelContainer(for: TaskModel.self)
  }
}
