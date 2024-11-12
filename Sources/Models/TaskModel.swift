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
  
  init(name: String) {
    self.name = name
  }
}
