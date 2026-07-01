//
//  TaskModel.swift
//  iReminder
//
//  Created by Jessy Viranaiken on 16/09/2024.
//

import SwiftData
import Foundation

@Model
final class TaskModel: Identifiable {
  var id: UUID = UUID()
  var name: String
  var isCompleted: Bool = false
  var scheduledTime: Date?
  var taskType: String?
  var isUrgent: Bool?
  
  init(name: String, scheduledTime: Date? = nil, taskType: String? = nil, isUrgent: Bool? = nil) {
    self.name = name
    self.scheduledTime = scheduledTime
    self.taskType = taskType
    self.isUrgent = isUrgent
  }
}
