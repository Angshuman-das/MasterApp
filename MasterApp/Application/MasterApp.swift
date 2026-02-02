//
//  MasterAppApp.swift
//  MasterApp
//
//  Created by Angshuman on 02/02/26.
//

import SwiftUI

@main
struct MasterAppApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                StockListView()
            }
        }
    }
}
