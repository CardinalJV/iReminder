//
//  TaskItem.swift
//  WidgetsExtension
//
//  Created by Jessy Viranaiken on 04/11/2024.
//

import SwiftUI
import AppIntents

struct TaskItem: View {
  
//  let taskController: TaskController
  @State var task: TaskModel
  
  @State private var viewOffset: CGFloat = 0
  @State private var showRemoveButton = false
  @State private var removeRow = false
  @State private var isEditing = false
  @State private var text = ""
  @FocusState private var isTextFieldFocused: Bool
//  let markAsCompletedIntent: MarkTaskAsCompleted
  
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
          .foregroundStyle(.background)
        /* - */
        HStack(spacing: 16){
          /* Checkmark button */
          Button {
            self.task.isCompleted.toggle()
          } label: {
            ZStack{
              RoundedRectangle(cornerRadius: 5)
                .stroke(.black, lineWidth: 5)
                .fill(self.task.isCompleted ? .black : .white)
                .animation(self.task.isCompleted ? .easeOut(duration: 0.3) : .default, value: self.task.isCompleted)
                .frame(width: 25, height: 25)
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
          /* - */
          Spacer()
        }
        .padding()
        .frame(width: 300, height: 50) // Height of taskItem
        RoundedRectangle(cornerRadius: 8)
          .stroke(style: StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
      }
      .offset(x: viewOffset)
      .fixedSize(horizontal: false, vertical: true)
      .padding(.horizontal, 24)
    }
  }
}
