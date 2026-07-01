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
  
  @State private var taskListViewModel = TaskListViewModel()
  @State private var weatherViewModel = WeatherViewModel()
  
  var body: some Scene {
    WindowGroup {
      NavigationStack {
        LandingView()
      }
      .environment(taskListViewModel)
      .environment(weatherViewModel)
    }
    .modelContainer(for: TaskModel.self)
  }
}
