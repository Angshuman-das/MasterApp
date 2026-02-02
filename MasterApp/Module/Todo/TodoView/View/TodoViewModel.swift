//
//  TodoViewModel.swift
//  MasterApp
//
//  Created by Angshuman on 03/02/26.
//

import Foundation
import Combine
import SwiftData

protocol TodoViewModelProtocol: ObservableObject {
    var selectedUpdateItem: TodoItem? { get }
    
    var shouldShowAddAlert: Bool { get set }
    var shouldShowUpdateAlert: Bool { get set }
    
    var title: String { get set }
    var subtitle: String { get set }
    
    func updateShowAddAlert(_ showAlert: Bool)
    func updateShowUpdateAlert(_ showAlert: Bool)
    
    func addItem(context: ModelContext)
    func deleteItem(_ item: TodoItem, context: ModelContext)
    func updateItem(_ item: TodoItem?, updateStatus: Bool)
    
    func selectUpdateItem(_ item: TodoItem)
}

class TodoViewModel: TodoViewModelProtocol {
    @Published var selectedUpdateItem: TodoItem?
    
    @Published var title: String = ""
    @Published var subtitle: String = ""
    
    @Published var shouldShowAddAlert: Bool = false
    @Published var shouldShowUpdateAlert: Bool = false
    
    private var dataManager: TodoDataManagerProtocol
    
    init(dataManager: TodoDataManagerProtocol = TodoDataManager()) {
        self.dataManager = dataManager
    }
    
    func addItem(context: ModelContext) {
        guard !title.isEmpty,
              !subtitle.isEmpty else {
                  return
              }
        
        let item = TodoItem(title: title, subtitle: subtitle)
        dataManager.addItem(item, context: context)
        resetTextFields()
    }
    
    func deleteItem(_ item: TodoItem, context: ModelContext) {
        dataManager.deleteItem(item, context: context)
    }
    
    func updateItem(_ item: TodoItem?, updateStatus: Bool) {
        guard let item else { return }
        if updateStatus {
            dataManager.updateItem(item, update: .init(status: item.nextStatus))
        } else {
            dataManager.updateItem(item, update: .init(title: title, subtitle: subtitle))
            resetTextFields()
        }
    }
    
    func updateShowAddAlert(_ showAlert: Bool) {
        self.shouldShowAddAlert = showAlert
    }
    
    func updateShowUpdateAlert(_ showAlert: Bool) {
        self.shouldShowUpdateAlert = showAlert
    }
    
    func selectUpdateItem(_ item: TodoItem) {
        self.title = item.title
        self.subtitle = item.subtitle
        self.selectedUpdateItem = item
    }
}

extension TodoViewModel {
    func resetTextFields() {
        self.title = ""
        self.subtitle = ""
    }
}
