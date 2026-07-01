  //
  //  CustomTextWrapper.swift
  //  iReminder
  //
  //  Created by Jessy Viranaiken on 29/10/2024.
  //

import SwiftUI

struct CustomTextWrapper: View {
  
  let taskListViewModel: TaskListViewModel
  
  @State var task: TaskModel
  @State private var isEditing = false
  @State private var text = ""
  @FocusState private var isTextFieldFocused: Bool
  
  var body: some View {
    VStack{
      if isEditing {
        TextField("Task name", text: self.$text, axis: .vertical)
          .focused($isTextFieldFocused)
          .onSubmit {
            isEditing = false
            if self.text != self.task.name {
              self.task.name = self.text
              self.taskListViewModel.updateTasks()
            }
          }
          // Focus change
          .onChange(of: isTextFieldFocused) {
            if !isTextFieldFocused {
              isEditing = false
              self.task.name = self.text
              self.taskListViewModel.updateTasks()
            }
          }
          .bold()
          .font(.body)
          .fontDesign(.monospaced)
          .lineLimit(2, reservesSpace: false)
          .multilineTextAlignment(.leading)
          .tracking(-0.75)
          .foregroundStyle(Color.label)
          .animation(.easeInOut(duration: 0.3).delay(1), value: self.task.isCompleted)
          .overlay(alignment: .leading) {
            animatedStrikethrough(for: self.text)
          }
      } else {
        Text(self.task.name)
          .onTapGesture {
            isEditing = true
            isTextFieldFocused = true
          }
          .bold()
          .font(.body)
          .fontDesign(.monospaced)
          .lineLimit(2)
          .multilineTextAlignment(.leading)
          .tracking(-0.75)
          .foregroundStyle(Color.label)
          .animation(.easeInOut(duration: 0.3).delay(1), value: self.task.isCompleted)
          .overlay(alignment: .leading) {
            animatedStrikethrough(for: self.task.name)
          }
      }
    }
    .onAppear {
      self.text = self.task.name
    }
  }
  
  private func animatedStrikethrough(for value: String) -> some View {
    ZStack(alignment: .leading) {
      strikethroughText(for: value)
        .offset(y: -1)
      strikethroughText(for: value)
      strikethroughText(for: value)
        .offset(y: 1)
    }
    .mask(alignment: .leading) {
      GeometryReader { geometry in
        Rectangle()
          .frame(width: self.task.isCompleted ? geometry.size.width : 0)
      }
    }
    .animation(.default, value: self.task.isCompleted)
    .allowsHitTesting(false)
  }
  
  private func strikethroughText(for value: String) -> some View {
    Text(value)
      .bold()
      .font(.body)
      .fontDesign(.monospaced)
      .lineLimit(2)
      .multilineTextAlignment(.leading)
      .tracking(-0.75)
      .foregroundStyle(.clear)
      .strikethrough(true, color: .label)
  }
}

  //#Preview {
  //    CustomTextWrapper()
  //}
