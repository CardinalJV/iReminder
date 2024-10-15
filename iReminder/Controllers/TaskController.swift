  //
  //  TaskController.swift
  //  iReminder
  //
  //  Created by Jessy Viranaiken on 16/09/2024.
  //

import Foundation
import SwiftData

@Observable
class TaskController{
  
  var tasks: [TaskModel] = []
  var context: ModelContext? = nil
  
  func fetchTasks() {
    let request = FetchDescriptor<TaskModel>()
    do {
      let fetchedTasks = try context!.fetch(request)
      self.tasks = fetchedTasks
    } catch {
      print("Erreur")
    }
  }
  
  func addTask(task: TaskModel) {
    do {
      context!.insert(task)
      try context!.save()
      fetchTasks()
    } catch {
      print("Erreur lors de la sauvegarde")
    }
  }
  
  func deleteTask(task: TaskModel) {
    do {
      context!.delete(task)
      try context!.save()
      fetchTasks()
    } catch {
      print("Erreur lors de la suppression")
    }
  }
}
