//
//  TaskModel.swift
//  iReminder
//
//  Created by Jessy Viranaiken on 16/09/2024.
//

import Foundation
import SwiftData

@Model
class TaskModel: Identifiable {
  var id = UUID()
  var name: String
  var isCompleted = false
  
  init(name: String, isCompleted: Bool? = nil) {
    self.name = name
  }
}
