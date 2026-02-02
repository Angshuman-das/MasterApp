//
//  TodoView.swift
//  MasterApp
//
//  Created by Angshuman on 03/02/26.
//

import SwiftUI
import SwiftData

struct TodoView<VM: TodoViewModelProtocol>: View {
    
    @Environment(\.modelContext) var modelContext
    @StateObject var viewModel: VM
    
    @Query(
        sort: \TodoItem.createdAt,
        order: .reverse
    )
    private var items: [TodoItem]
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Group {
                if !items.isEmpty {
                    VStack {
                        List(items, id: \.id) { item in
                            TodoItemView(
                                viewModel: TodoItemViewModel(item: item)
                            )
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                
                                Button(role: .destructive) {
                                    viewModel.deleteItem(item, context: modelContext)
                                }
                                
                                Button {
                                    viewModel.updateItem(item, updateStatus: true)
                                } label: {
                                    VStack(alignment: .leading) {
                                        Image(systemName: item.statusImage)
                                        Text(item.status.rawValue)
                                            .bold()
                                    }
                                }
                            }
                            .onTapGesture {
                                viewModel.selectUpdateItem(item)
                                viewModel.updateShowUpdateAlert(true)
                            }
                        }
                    }
                } else {
                    Text("TODO list is empty, Please add todo items for your ease")
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        viewModel.updateShowAddAlert(true)
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 54, height: 54)
                    }
                    .padding()
                }
            }
        }
        .alert("Add todo item", isPresented: $viewModel.shouldShowAddAlert) {
            TextField("Title", text: $viewModel.title)
            TextField("Subtitle", text: $viewModel.subtitle)
            
            Button("Close") {
                viewModel.updateShowAddAlert(false)
            }
            
            Button("Add") {
                viewModel.addItem(context: modelContext)
                viewModel.updateShowAddAlert(false)
            }
        }
        .alert("Update item", isPresented: $viewModel.shouldShowUpdateAlert) {
            TextField("Title", text: $viewModel.title)
            TextField("Subtitle", text: $viewModel.subtitle)
            
            Button("Close") {
                viewModel.updateShowUpdateAlert(false)
            }
            
            Button("Update") {
                viewModel.updateItem(viewModel.selectedUpdateItem, updateStatus: false)
                viewModel.updateShowUpdateAlert(false)
            }
        }
    }
}

#Preview {
    TodoView(viewModel: TodoViewModel())
}
