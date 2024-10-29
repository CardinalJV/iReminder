  //
  //  TaskController.swift
  //  iReminder
  //
  //  Created by Jessy Viranaiken on 16/09/2024.
  //

import Foundation
import SwiftData
import SwiftUI

@Observable
class TaskController{
  
  var tasks: [TaskModel] = []
  var context: ModelContext? = nil
  
    //  Create
  func add(this task: TaskModel) {
    do {
      context!.insert(task)
      try context!.save()
      fetchTasks()
    } catch {
      print("Erreur lors de la sauvegarde")
    }
  }
    //  Read
  func fetchTasks() {
    let request = FetchDescriptor<TaskModel>()
    do {
      let fetchedTasks = try context!.fetch(request)
      self.tasks = fetchedTasks
    } catch {
      print("Erreur")
    }
  }
    //  Delete
  func delete(this task: TaskModel) {
    do {
      context!.delete(task)
      try context!.save()
      fetchTasks()
    } catch {
      print("Erreur lors de la suppression")
    }
  }
  
  func sortTasks() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
      withAnimation {
        self.tasks.sort{ !$0.isCompleted && $1.isCompleted }
      }
    }
  }
}
