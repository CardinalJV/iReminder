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
  @Environment(TaskListViewModel.self) private var taskListViewModel
  @Environment(WeatherViewModel.self) private var weatherViewModel
  
  @State private var showAddNewTaskView = false
  
  var body: some View {
    VStack(spacing: 20){
      HStack{
        Text(Date.now.formatted(.dateTime.day().month()))
          .bold()
          .font(.title)
        Spacer()
        HStack(spacing: 14){
          HStack(spacing: 8){
            Text("\(taskListViewModel.tasks.filter{$0.isCompleted}.count)")
              .animation(.bouncy(duration: 1), value: taskListViewModel.tasks.filter{ $0.isCompleted }.count)
            Image(systemName: "checkmark")
          }
          HStack(spacing: 5){
            Image(systemName: weatherViewModel.symbolName)
              .foregroundStyle(.black)
            Text(weatherViewModel.temperatureText)
          }
          .padding(.leading, 4)
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
          ForEach(taskListViewModel.tasks, id: \.id) { task in
            TaskItem(task: task)
              .transition(.move(edge: .leading))
          }
        }
        .padding(.vertical)
        .animation(.bouncy, value: taskListViewModel.tasks)
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
      taskListViewModel.context = self.context
      taskListViewModel.fetchTasks()
      weatherViewModel.requestWeather()
    }
    .sheet(isPresented: self.$showAddNewTaskView) {
      AddNewTaskView(taskListViewModel: taskListViewModel)
        .presentationDetents([.fraction(0.25)])
        .onDisappear{
          self.showAddNewTaskView = false
        }
    }
  }
}

#Preview {
  @Previewable @State var taskListViewModel = TaskListViewModel()
  @Previewable @State var weatherViewModel = WeatherViewModel()
  
  LandingView()
    .environment(taskListViewModel)
    .environment(weatherViewModel)
    .modelContainer(for: TaskModel.self)
}
