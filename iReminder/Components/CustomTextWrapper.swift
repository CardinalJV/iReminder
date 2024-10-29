//
//  CustomTextWrapper.swift
//  iReminder
//
//  Created by Jessy Viranaiken on 29/10/2024.
//

import SwiftUI

struct CustomTextWrapper: View {
  
  @State var task: TaskModel
  @State private var isEditing = false
  @State private var text = ""
  @FocusState private var isTextFieldFocused: Bool
  
  var body: some View {
    VStack{
      if isEditing {
        TextField("Nom de la tache", text: self.$text)
          .focused($isTextFieldFocused)
          .onSubmit {
            isEditing = false
            if self.text != self.task.name {
              self.task.name = self.text
            }
          }
          .onChange(of: isTextFieldFocused) {
            if !isTextFieldFocused {
              isEditing = false
              self.task.name = self.text
            }
          }
          .font(.system(size: 20, weight: .semibold, design: .monospaced))
          .tracking(-0.75)
          .colorMultiply(self.task.isCompleted ? .green : .label)
          .animation(.easeInOut(duration: 0.3).delay(1), value: self.task.isCompleted)
          .overlay(alignment: .leading){
            Rectangle()
              .stroke(lineWidth: 2)
              .offset(y: 2)
              .opacity(self.task.isCompleted ? 1 : 0)
              .frame(width: self.task.isCompleted ? .none : 0, height: 1)
              .animation(.default, value: self.task.isCompleted)
          }
      } else {
        Text(self.task.name)
          .onTapGesture {
            isEditing = true
            isTextFieldFocused = true
          }
          .font(.system(size: 20, weight: .semibold, design: .monospaced))
          .tracking(-0.75)
          .colorMultiply(self.task.isCompleted ? .green : .label)
          .animation(.easeInOut(duration: 0.3).delay(1), value: self.task.isCompleted)
          .overlay(alignment: .leading){
            Rectangle()
              .stroke(lineWidth: 2)
              .offset(y: 2)
              .opacity(self.task.isCompleted ? 1 : 0)
              .frame(width: self.task.isCompleted ? .none : 0, height: 1)
              .animation(.default, value: self.task.isCompleted)
          }
      }
    }
    .onAppear {
      self.text = self.task.name
    }
  }
}

//#Preview {
//    CustomTextWrapper()
//}
