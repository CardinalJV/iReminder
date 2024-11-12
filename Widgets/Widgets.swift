  //
  //  Widgets.swift
  //  Widgets
  //
  //  Created by Jessy Viranaiken on 30/10/2024.
  //

import WidgetKit
import SwiftUI
import SwiftData

struct Provider: TimelineProvider {
  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry(date: Date(), tasks: [TaskModel(name: "")])
  }
  
  func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
    let entry = SimpleEntry(date: Date(), tasks: [TaskModel(name: "")])
    completion(entry)
  }
  
  func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    var entries: [SimpleEntry] = []
    let entry = SimpleEntry(date: .now, tasks: [TaskModel(name: "")])
    entries.append(entry)
    
    let timeline = Timeline(entries: entries, policy: .atEnd)
    completion(timeline)
  }
}

struct SimpleEntry: TimelineEntry {
  let date: Date
  let tasks: [TaskModel]
}

struct WidgetsEntryView : View {
  var entry: SimpleEntry
  @Query(taskDescriptor, animation: .snappy) private var tasks: [TaskModel]
  var body: some View {
    VStack{
      VStack(spacing: 15){
        ForEach(tasks, id:\.id) { task in
          TaskItem(task: task)
          }
        }
      }
    }
  
  static var taskDescriptor: FetchDescriptor<TaskModel> {
    let predicate = #Predicate<TaskModel> { !$0.isCompleted }
    var descriptor = FetchDescriptor(predicate: predicate)
    descriptor.fetchLimit = 2
    return descriptor
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
  SimpleEntry(date: .now, tasks: [TaskModel(name: "")])
}

