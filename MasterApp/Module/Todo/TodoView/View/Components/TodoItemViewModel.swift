//
//  TodoItemViewModel.swift
//  MasterApp
//
//  Created by Angshuman on 03/02/26.
//

import Foundation
import Combine

protocol TodoItemViewModelProtocol: ObservableObject {
    var item: TodoItem { get }
}

class TodoItemViewModel: TodoItemViewModelProtocol {
    @Published var item: TodoItem
    
    init(item: TodoItem) {
        self.item = item
    }
}
