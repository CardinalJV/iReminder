  //
  //  TaskController.swift
  //  iReminder
  //
  //  Created by Jessy Viranaiken on 16/09/2024.
  //

import SwiftData
import SwiftUI

@Observable
class TaskController{
  
  var tasks: [TaskModel] = []
  var context: ModelContext?
  
    //  Create
  func add(this task: TaskModel) {
    guard let context = self.context else {
      print("Context indisponible")
      return
    }
    do {
      context.insert(task)
      try context.save()
      fetchTasks()
    } catch {
      print("Erreur lors de l'ajout : \(error)")
    }
  }
    //  Read
  func fetchTasks() {
    let request = FetchDescriptor<TaskModel>()
    do {
      if let fetchedTasks = try context?.fetch(request) {
        self.tasks = fetchedTasks
      }
    } catch {
      print("Erreur lors de la récupération des taches: \(error)")
    }
  }
    //  Update
  func updateTasks() {
    guard let context = self.context else {
      print("Context indisponible")
      return
    }
    do {
      try context.save()
      fetchTasks()
    } catch {
      print("Erreur lors de la sauvegarde: \(error)")
    }
  }
    //  Delete
  func delete(this task: TaskModel) {
    guard let context = self.context else {
      print("Context indisponible")
      return
    }
    do {
      context.delete(task)
      try context.save()
      fetchTasks()
    } catch {
      print("Erreur lors de la suppression: \(error)")
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
