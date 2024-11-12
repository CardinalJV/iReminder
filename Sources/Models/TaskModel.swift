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
  var id: UUID = UUID()
  var name: String
  var isCompleted: Bool = false
  
  init(name: String) {
    self.name = name
  }
}