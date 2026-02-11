//
//  HomeViewModel.swift
//  MasterApp
//
//  Created by Angshuman on 08/02/26.
//

import Foundation
import Combine
import SwiftUI

enum Screens: String, CaseIterable {
    case todo = "TODO"
    case stock = "STOCK"
    case stopwatch = "STOP WATCH"
}

protocol HomeViewModelProtocol: ObservableObject {
    var screens: [Screens] { get }
    
    func fetchScreens()
    func navigateTo(screen: Screens) -> AnyView
}

class HomeViewModel: HomeViewModelProtocol {
    
    @Published var screens: [Screens] = []
    
    init() {
        fetchScreens()
    }
    
    func fetchScreens() {
        Screens.allCases.forEach { screen in
            screens.append(screen)
        }
    }
    
    func navigateTo(screen: Screens) -> AnyView {
        switch screen {
        case .todo:
            return AnyView(TodoView(viewModel: TodoViewModel()))
        case .stock:
            return AnyView(StockListView(viewModel: StockListViewModel()))
        case .stopwatch:
            return AnyView(StopwatchView())
        }
    }
}
