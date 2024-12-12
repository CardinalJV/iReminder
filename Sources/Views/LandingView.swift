  //
  //  LandingView.swift
  //  iReminder
  //
  //  Created by Jessy Viranaiken on 16/09/2024.
  //

import SwiftUI
import SwiftData

struct LandingView: View {
  
  @Environment(\.modelContext) var context: ModelContext
  @Environment(TaskController.self) private var taskController
  
  @State private var showAddNewTaskView = false
  
  var body: some View {
    VStack(spacing: 20){
      HStack{
        Text(Date.now.formatted(.dateTime.day().month()))
          .bold()
          .font(.title)
        Spacer()
        HStack{
          Text("\(taskController.tasks.filter{$0.isCompleted}.count)")
            .animation(.bouncy(duration: 1), value: taskController.tasks.filter{ $0.isCompleted }.count)
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
          ForEach(taskController.tasks, id: \.id) { task in
            TaskItem(task: task)
              .transition(.move(edge: .leading))
          }
        }
        .padding(.vertical)
        .animation(.bouncy, value: taskController.tasks)
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
      taskController.context = self.context
      taskController.fetchTasks()
    }
    .sheet(isPresented: self.$showAddNewTaskView) {
      AddNewTaskView(taskController: taskController)
        .presentationDetents([.fraction(0.25)])
        .onDisappear{
          self.showAddNewTaskView = false
        }
    }
  }
}

#Preview {
  @Previewable @State var taskController = TaskController()
  
  LandingView()
    .environment(taskController)
    .modelContainer(for: TaskModel.self)
}
