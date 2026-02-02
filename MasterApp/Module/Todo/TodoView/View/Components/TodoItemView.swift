//
//  TodoItemView.swift
//  MasterApp
//
//  Created by Angshuman on 03/02/26.
//

import SwiftUI

struct TodoItemView<VM: TodoItemViewModelProtocol>: View {
    
    @ObservedObject var viewModel: VM
    
    init(viewModel: VM) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(viewModel.item.title)
                .font(.title2)
                .bold()
            
            Text(viewModel.item.subtitle)
                .font(.title3)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.all, 12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(
                    viewModel.item.backroundColor
                )
        )
    }
}

#Preview {
    TodoItemView(viewModel: TodoItemViewModel(item: TodoItem(title: "Cooking", subtitle: "Time to cook some good food", status: .completed)))
    
    TodoItemView(viewModel: TodoItemViewModel(item: TodoItem(title: "Dancing", subtitle: "Time to dance")))
    
    TodoItemView(viewModel: TodoItemViewModel(item: TodoItem(title: "Cooking", subtitle: "Time to cook some good food", status: .inProgress)))
}
