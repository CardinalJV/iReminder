//
//  iReminderApp.swift
//  iReminder
//
//  Created by Jessy Viranaiken on 15/10/2024.
//

import SwiftUI
import SwiftData

@main
struct iReminderApp: App {
    var body: some Scene {
        WindowGroup {
            LandingView()
        }
        .modelContainer(for: TaskModel.self)
    }
}
