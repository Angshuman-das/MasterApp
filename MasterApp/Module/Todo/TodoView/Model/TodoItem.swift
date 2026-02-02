//
//  TodoItem.swift
//  MasterApp
//
//  Created by Angshuman on 03/02/26.
//

import Foundation
import SwiftData
import SwiftUI

enum TodoItemStatus: String, Codable {
    case pending = "Pending"
    case inProgress = "In Progress"
    case completed = "Completed"
}

@Model
class TodoItem: Identifiable {
    @Attribute(.unique)
    var id: UUID
    
    var title: String
    var subtitle: String
    var createdAt: Date
    var status: TodoItemStatus
    
    init(
        id: UUID = UUID(),
        title: String,
        subtitle: String,
        createdAt: Date = Date(),
        status: TodoItemStatus = .pending
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.createdAt = createdAt
        self.status = status
    }
}

extension TodoItem {
    var backroundColor: Color {
        switch status {
        case .pending:
            Color.yellow
        case .inProgress:
            Color.red
        case .completed:
            Color.green
        }
    }
    
    var nextStatus: TodoItemStatus {
        switch status {
        case .pending:
                .inProgress
        case .inProgress:
                .completed
        case .completed:
                .pending
        }
    }
    
    var statusImage: String {
        switch status {
        case .pending:
            "play.circle.fill"
        case .inProgress:
            "checkmark.circle.fill"
        case .completed:
            "arrow.counterclockwise.circle.fill"
        }
    }
}
