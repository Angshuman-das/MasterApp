//
//  TodoDataManager.swift
//  MasterApp
//
//  Created by Angshuman on 03/02/26.
//

import Foundation
import SwiftData

protocol TodoDataManagerProtocol {
    func addItem(_ item: TodoItem, context: ModelContext)
    func updateItem(_ item: TodoItem, update: TodoItemUpdate)
    func deleteItem(_ item: TodoItem, context: ModelContext)
}

class TodoDataManager: TodoDataManagerProtocol {
    func addItem(_ item: TodoItem, context: ModelContext) {
        context.insert(item)
    }
    
    func updateItem(_ item: TodoItem, update: TodoItemUpdate) {
        if let title = update.title { item.title = title }
        if let subtitle = update.subtitle { item.subtitle = subtitle }
        if let status = update.status { item.status = status }
    }
    
    func deleteItem(_ item: TodoItem, context: ModelContext) {
        context.delete(item)
    }
}
