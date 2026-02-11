//
//  HomeScreen.swift
//  MasterApp
//
//  Created by Angshuman on 08/02/26.
//

import SwiftUI

struct HomeScreen<VM: HomeViewModelProtocol>: View {
    
    @StateObject var viewModel: VM
    
    init(viewModel: VM = HomeViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            List(viewModel.screens, id: \.self) { screen in
                    
                NavigationLink {
                    viewModel.navigateTo(screen: screen)
                } label: {
                    Text(screen.rawValue)
                        .font(.title3)
                        .bold()
                }
            }
        }
        .navigationTitle("Projects")
    }
}

#Preview {
    HomeScreen()
}
