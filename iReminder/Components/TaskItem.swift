  //
  //  TaskItem.swift
  //  iReminder
  //
  //  Created by Jessy Viranaiken on 15/10/2024.
  //

import SwiftUI

struct TaskItem: View {
  
  let taskController: TaskController
  let task: TaskModel
  @State var isCompleted = false
  
  var body: some View {
    HStack {
      Text(task.name)
      Spacer()
      Button(action: {
        self.isCompleted = true
        if let context = taskController.context {
          DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            task.isCompleted = true
            try? context.save()
          }
        }
      }) {
        Image(systemName: self.isCompleted  ? "checkmark.circle.fill" : "circle")
          .resizable()
          .frame(width: 24, height: 24)
      }
    }
    .padding()
    .frame(height: 45)
    .background(.white)
    .cornerRadius(10)
  }
}
