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
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack(spacing: 14) {
                    Text(Date.now.formatted(.dateTime.day().month()))
                        .font(.body)
                        .lineLimit(1)
                        .fixedSize(horizontal: true, vertical: false)
                    RoundedRectangle(cornerRadius: 1)
                        .fill(Color.label)
                        .frame(width: 2, height: 16)
                    HStack(spacing: 2) {
                        Text(weatherViewModel.temperatureText)
                            .font(.body)
                            .lineLimit(1)
                            .fixedSize(horizontal: true, vertical: false)
                        Image(systemName: weatherViewModel.symbolName)
                            .foregroundStyle(Color.label)
                            .font(.footnote)
                    }
                    .fixedSize(horizontal: true, vertical: false)
                }
                .padding()
                .bold()
                .fontDesign(.monospaced)
            }
            ToolbarItem(placement: .topBarTrailing) {
                HStack(spacing: 2) {
                    Text("\(taskListViewModel.tasks.filter { $0.isCompleted }.count)")
                        .animation(.bouncy(duration: 1), value: taskListViewModel.tasks.filter { $0.isCompleted }.count)
                        .font(.body)
                    Image(systemName: "checkmark")
                        .font(.footnote)
                }
                .padding()
                .bold()
                .fontDesign(.monospaced)
            }
            ToolbarItem(placement: .bottomBar) {
                Button {
                    self.showAddNewTaskView = true
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(Color.label)
                        .font(.body)
                        .bold()
                }
                .buttonStyle(.plain)
            }
        }
        .onAppear{
            taskListViewModel.context = self.context
            taskListViewModel.fetchTasks()
            weatherViewModel.requestWeather()
        }
        .sheet(isPresented: self.$showAddNewTaskView) {
            AddNewTaskView(taskListViewModel: taskListViewModel)
                .presentationDetents([.fraction(0.55)])
                .onDisappear{
                    self.showAddNewTaskView = false
                }
        }
    }
}

#Preview {
    @Previewable @State var taskListViewModel = TaskListViewModel()
    @Previewable @State var weatherViewModel = WeatherViewModel()
    
    NavigationStack {
        LandingView()
    }
    .environment(taskListViewModel)
    .environment(weatherViewModel)
    .modelContainer(for: TaskModel.self)
}
