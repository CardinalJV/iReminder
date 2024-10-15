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
  var taskController = TaskController()
  
  @State private var isPresentedAddNewTaskView = false
  @State private var isPresentedTaskCompleted = false
  @State private var showAnimation = false
  
  var body: some View {
    ZStack{
      Color(.systemGray6)
        .ignoresSafeArea()
      VStack{
        if self.taskController.tasks.isEmpty{
          Spacer()
          Button {
            self.isPresentedAddNewTaskView = true
          } label: {
            Text("Ajouter")
              .padding(.init(top: 10, leading: 25, bottom: 10, trailing: 25))
              .background(.blue)
              .foregroundStyle(.white)
              .clipShape(.rect(cornerRadius: 10))
              .bold()
          }
        } else {
          ScrollView{
            /* Component task no-complete */
            VStack{
              ForEach(taskController.tasks.filter{!$0.isCompleted}, id: \.id) { task in
                TaskItem(taskController: self.taskController, task: task)
              }
            }
            .padding()
            /* - */
            /* Component task complete */
            VStack(alignment: .leading){
              if !taskController.tasks.filter({$0.isCompleted}).isEmpty {
                HStack{
                  Spacer()
                  Image(systemName: "arrow.down.app.fill")
                    .font(.title)
                    .rotationEffect(.degrees(self.isPresentedTaskCompleted ? 0 : 180)) // Rotation de l'image
                    .animation(.easeInOut(duration: 0.4), value: self.isPresentedTaskCompleted)
                  Text("\(self.isPresentedTaskCompleted ? "Masquer" : "Afficher") les rappels terminés")
                    .bold()
                  Image(systemName: "arrow.down.app.fill")
                    .font(.title)
                    .rotationEffect(.degrees(self.isPresentedTaskCompleted ? 0 : -180)) // Rotation de l'image
                    .animation(.easeInOut(duration: 0.4), value: self.isPresentedTaskCompleted)
                  Spacer()
                }
                .foregroundStyle(.gray)
                .frame(width: 375, alignment: .leading)
                .onTapGesture {
                  self.isPresentedTaskCompleted.toggle()
                }
                if self.isPresentedTaskCompleted {
                  ForEach(taskController.tasks.filter{$0.isCompleted}, id: \.id) { task in
                    HStack{
                      Text(task.name)
                      Spacer()
                      Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .onTapGesture {
                          self.taskController.deleteTask(task: task)
                        }
                    }
                    .padding()
                    .bold()
                    .frame(height: 45)
                    .foregroundStyle(.gray)
                    .background(Color(.systemGray4))
                    .clipShape(.rect(cornerRadius: 10))
                  }
                }
              }
            }
            .padding()
            /* - */
          }
        }
        Spacer()
        Button {
          self.isPresentedAddNewTaskView = true
        } label: {
          Image(systemName: "plus")
        }
        .frame(width: 50, height: 50)
        .background(.blue)
        .clipShape(.circle)
        .font(.largeTitle)
        .foregroundStyle(.white)
        .bold()
      }
    }
    .onAppear{
      self.showAnimation.toggle()
      self.taskController.context = self.context
      self.taskController.fetchTasks()
    }
    .sheet(isPresented: self.$isPresentedAddNewTaskView){
      AddNewTaskView(taskController: self.taskController)
        .presentationDetents([.fraction(0.25)])
    }
  }
}

#Preview {
  LandingView()
    .modelContainer(for: TaskModel.self)
}
