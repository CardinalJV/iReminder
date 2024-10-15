//
//  AddNewTaskView.swift
//  iReminder
//
//  Created by Jessy Viranaiken on 10/10/2024.
//

import SwiftUI

struct AddNewTaskView: View {
  @Environment(\.dismiss) private var dismiss
  
  let taskController: TaskController
  
  @State private var text = ""
  
    var body: some View {
      ZStack{
        Color(.systemGray6)
          .ignoresSafeArea()
        VStack{
          TextField("Ajouter un nom", text: self.$text)
            .padding()
            .frame(height: 45)
            .background(.white)
            .foregroundStyle(.black)
            .clipShape(.rect(cornerRadius: 10))
          Button("Ajouter") {
            if !self.text.isEmpty {
              self.taskController.addTask(task: TaskModel(name: self.text))
              self.dismiss()
            }
          }
          .padding()
          .frame(width: 375, height: 45)
          .foregroundStyle(.white)
          .background(.blue)
          .clipShape(.rect(cornerRadius: 10))
          .bold()
          Spacer()
        }
        .padding()
      }
      .onSubmit {
        if !self.text.isEmpty {
          self.taskController.addTask(task: TaskModel(name: self.text))
          self.dismiss()
        }
      }
    }
}
//
//#Preview {
//  AddNewTaskView(taskManager: <#TaskManager#>, text: .constant(""))
//}
