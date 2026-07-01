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
  
  @State private var text = ""
  @State private var includesTime = false
  @State private var scheduledTime = Date()
  @State private var includesType = false
  @State private var selectedType = "Home"
  @State private var isUrgent = false
  
  private let taskTypes = ["Home", "Work", "Personal"]
  
  var body: some View {
    VStack(spacing: 14){
      TextField("Write a task", text: self.$text)
        .padding()
        .font(.headline)
        .frame(width: 370, height: 50)
        .multilineTextAlignment(.center)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
      
      VStack(spacing: 10) {
        Toggle("Time", isOn: $includesTime)
        if includesTime {
          DatePicker("", selection: $scheduledTime, displayedComponents: .hourAndMinute)
            .datePickerStyle(.compact)
            .labelsHidden()
        }
        
        Toggle("Type", isOn: $includesType)
        if includesType {
          Picker("Type", selection: $selectedType) {
            ForEach(taskTypes, id: \.self) { type in
              Text(type).tag(type)
            }
          }
          .pickerStyle(.segmented)
        }
        
        Toggle("Urgent", isOn: $isUrgent)
          .tint(.red)
      }
      .font(.body)
      .frame(width: 370)
      
      Button {
        addTaskIfNeeded()
      } label: {
        Text("Add")
          .font(.body)
          .bold()
          .foregroundStyle(.white)
          .frame(width: 375, height: 50)
          .background(.black)
          .clipShape(RoundedRectangle(cornerRadius: 10))
      }
    }
    .padding()
    .fontDesign(.monospaced)
    .tint(.black)
    .onSubmit {
      addTaskIfNeeded()
    }
  }
  
  private func addTaskIfNeeded() {
    guard !self.text.isEmpty else { return }
    
    let task = TaskModel(
      name: self.text,
      scheduledTime: includesTime ? scheduledTime : nil,
      taskType: includesType ? selectedType : nil,
      isUrgent: isUrgent ? true : nil
    )
    self.taskListViewModel.add(this: task)
    self.dismiss()
  }
}
