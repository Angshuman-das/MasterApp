//
//  MasterAppApp.swift
//  MasterApp
//
//  Created by Angshuman on 02/02/26.
//

import SwiftUI
import SwiftData

@main
struct MasterAppApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeScreen(viewModel: HomeViewModel())
            }
        }
        .modelContainer(for: TodoItem.self)
    }
}
