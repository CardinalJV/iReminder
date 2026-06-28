//
//  AddNewTaskView.swift
//  iReminder
//
//  Created by Jessy Viranaiken on 10/10/2024.
//

import SwiftUI

struct AddNewTaskView: View {
  
  @Environment(\.dismiss) private var dismiss
  let taskListViewModel: TaskListViewModel
  
  @State var text = ""
  
  var body: some View {
    VStack(spacing: 20){
      Button {
        self.dismiss()
      } label: {
        RoundedRectangle(cornerRadius: 5)
          .frame(width: 50, height: 5, alignment: .top)
      }
      .buttonStyle(.plain)
      TextField("Add a task", text: self.$text)
        .padding()
        .font(.headline)
        .frame(width: 370, height: 50)
        .background(Color(UIColor.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .multilineTextAlignment(.center)
      Button {
        if !self.text.isEmpty {
          self.taskListViewModel.add(this: TaskModel(name: self.text))
          self.dismiss()
        }
      } label: {
        Text("Add")
          .font(.headline)
          .foregroundStyle(.white)
          .bold()
          .frame(width: 375, height: 50)
          .background(.black)
          .clipShape(RoundedRectangle(cornerRadius: 10))
      }
    }
    .padding()
    .fontDesign(.monospaced)
    .tint(.black)
    .onSubmit {
      if !self.text.isEmpty {
        self.taskListViewModel.add(this: TaskModel(name: self.text))
        self.dismiss()
      }
    }
  }
}
