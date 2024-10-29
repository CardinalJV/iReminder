  //
  //  LandingView.swift
  //  iReminder
  //
  //  Created by Jessy Viranaiken on 16/09/2024.
  //

import SwiftUI
import SwiftData

struct LandingView: View {
  
  @Environment(\.modelContext) private var context
  let taskController = TaskController()
  
  @State private var showAddNewTaskView = false
  @State private var showTaskCompleted = false
  @State private var showAnimation = false
  
  var body: some View {
    VStack(spacing: 20){
      HStack{
        Text(Date.now.formatted(.dateTime.day().month()))
          .bold()
          .font(.title)
        Spacer()
        HStack{
          Text("\(self.taskController.tasks.filter{$0.isCompleted}.count)")
            .animation(.bouncy(duration: 1), value: self.taskController.tasks.filter{ $0.isCompleted }.count)
          Image(systemName: "checkmark")
        }
        .bold()
        .font(.title3)
      }
      .frame(width: 355,alignment: .leading)
      .fontDesign(.monospaced)
      RoundedRectangle(cornerRadius: 2)
        .frame(width: 355, height: 4)
      ScrollView{
        VStack(spacing: 20){
          ForEach(self.taskController.tasks, id: \.id) { task in
            TaskItem(taskController: self.taskController, task: task)
              .transition(.move(edge: .leading).animation(.bouncy))
          }
        }
        .padding(.vertical)
        .animation(.bouncy, value: self.taskController.tasks)
      }
      Spacer()
      Button {
        self.showAddNewTaskView = true
      } label: {
        Image(systemName: "plus")
          .foregroundStyle(.black)
          .font(.largeTitle)
          .bold()
      }
    }
    .onAppear{
      self.showAnimation.toggle()
      self.taskController.context = self.context
      self.taskController.fetchTasks()
    }
    .sheet(isPresented: self.$showAddNewTaskView) {
      AddNewTaskView(taskController: self.taskController)
        .presentationDetents([.fraction(0.25)])
        .onDisappear {
          self.showAddNewTaskView = false
        }
    }
  }
}

#Preview {
  LandingView()
    .modelContainer(for: TaskModel.self)
}
