  //
  //  TaskItem.swift
  //  iReminder
  //
  //  Created by Jessy Viranaiken on 15/10/2024.
  //

import SwiftUI

struct TaskItem: View {
  
  @Environment(TaskController.self) private var taskController
  
  @State var task: TaskModel
  @State private var viewOffset: CGFloat = 0
  @State private var showRemoveButton = false
  
  let baseOffset: CGFloat = 0
  let deleteOffset: CGFloat = -40
  
  var dragGesture: some Gesture {
    DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
      .onEnded { value in
        if value.translation.width < 0 {
          withAnimation(.bouncy(duration: 0.30)) {
            self.viewOffset = deleteOffset
            self.showRemoveButton = true
          }
        } else if value.translation.width > 0 {
          withAnimation(.bouncy(duration: 0.30)) {
            self.viewOffset = baseOffset
            self.showRemoveButton = false
          }
        }
      }
  }
  
  var body: some View {
    HStack(spacing: 0) {
      ZStack{
        /* Shape shadow */
        RoundedRectangle(cornerRadius: 8)
          .offset(x: 4, y: 6)
        RoundedRectangle(cornerRadius: 8)
          .foregroundColor(.background)
        /* - */
        HStack(spacing: 8){
          /* Checkmark button */
          Button {
            self.task.isCompleted.toggle()
            self.taskController.sortTasks()
          } label: {
            ZStack{
              RoundedRectangle(cornerRadius: 5)
                .stroke(.black, lineWidth: 5)
                .fill(self.task.isCompleted ? .black : .white)
                .animation(self.task.isCompleted ? .easeOut(duration: 0.3) : .default, value: self.task.isCompleted)
                .frame(width: 30, height: 30)
              if (self.task.isCompleted) {
                Image(systemName: "checkmark")
                  .foregroundStyle(.white)
                  .frame(width: 24, height: 24)
                  .bold()
                  .animation(.easeInOut(duration: 0.25), value: self.task.isCompleted)
              }
            }
          }
          .buttonStyle(.plain)
          /* - */
          /* Task name field */
          CustomTextWrapper(taskController: self.taskController, task: self.task)
          /* - */
          Spacer()
        }
        .padding(14)
        RoundedRectangle(cornerRadius: 8)
          .stroke(style: StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
      }
      .offset(x: viewOffset)
      .fixedSize(horizontal: false, vertical: true)
      .padding(.horizontal, 24)
      .gesture(dragGesture)
      if self.showRemoveButton {
        Button {
          self.taskController.delete(this: self.task)
        } label: {
          Image(systemName: "multiply")
            .font(.largeTitle)
            .bold()
        }
        .padding()
        .buttonStyle(.plain)
        .transition(.scale.animation(.bouncy))
        .offset(x: -34)
        .frame(width: 32, height: 32)
      }
    }
  }
}
