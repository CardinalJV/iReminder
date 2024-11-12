  //
  //  Widgets.swift
  //  Widgets
  //
  //  Created by Jessy Viranaiken on 30/10/2024.
  //

import WidgetKit
import SwiftUI
import SwiftData
import AppIntents

struct Provider: TimelineProvider {
  func placeholder(in context: Context) -> TaskEntry {
    TaskEntry(date: Date(), tasks: [TaskModel(name: "")])
  }
  
  func getSnapshot(in context: Context, completion: @escaping (TaskEntry) -> ()) {
    let entry = TaskEntry(date: Date(), tasks: [TaskModel(name: "Task 1"), TaskModel(name: "Task 2")])
    completion(entry)
  }
  
  func getTimeline(in context: Context, completion: @escaping (Timeline<TaskEntry>) -> ()) {
      let tasks: [TaskModel] = []
      let entry = TaskEntry(date: .now, tasks: tasks)
      let timeline = Timeline(entries: [entry], policy: .atEnd)
      completion(timeline)
  }
}

struct TaskEntry: TimelineEntry {
  let date: Date
  let tasks: [TaskModel]
}

struct WidgetsEntryView : View {
  
  var entry: Provider.Entry
  static var taskDescriptor: FetchDescriptor<TaskModel> {
    let predicate = #Predicate<TaskModel> { !$0.isCompleted }
    var descriptor = FetchDescriptor(predicate: predicate)
    descriptor.fetchLimit = 2
    return descriptor
  }
  @Query(taskDescriptor, animation: .snappy) private var tasks: [TaskModel]
  
  var body: some View {
    VStack{
      VStack(spacing: 15){
        withAnimation{
          ForEach(tasks.sorted{ !$0.isCompleted && $1.isCompleted }, id:\.id) { task in
            TaskItem(task: task)
          }
        }
      }
    }
  }
}

struct Widgets: Widget {
  let kind: String = "Widgets"
  
  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: Provider()) { entry in
      WidgetsEntryView(entry: entry)
        .containerBackground(Color.background, for: .widget)
        .modelContainer(for: TaskModel.self)
    }
    .configurationDisplayName("Tasks")
    .description("This is my Tasks")
  }
}

#Preview(as: .systemMedium) {
  Widgets()
} timeline: {
  TaskEntry(date: .now, tasks: [TaskModel(name: "")])
}
