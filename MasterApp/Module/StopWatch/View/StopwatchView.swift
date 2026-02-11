//
//  StopwatchView.swift
//  MasterApp
//
//  Created by Angshuman on 11/02/26.
//

import SwiftUI

struct StopwatchView<VM: StopwatchViewModelProtocol>: View {
    
    @StateObject var viewModel: VM
    
    init(viewModel: VM = StopwatchViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            Text(viewModel.timerText)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            HStack {
                ForEach(ButtonAction.allCases, id: \.self) { action in
                    actionButton(action)
                }
            }
        }
    }
}

extension StopwatchView {
    @ViewBuilder
    private func actionButton(_ action: ButtonAction) -> some View {
        Button(action.rawValue) {
            switch action {
            case .start:
                viewModel.startStopWatch()
            case .pause:
                viewModel.pauseStopwatch(isResumeable: true)
            case .reset:
                viewModel.resetStopwatch()
            }
        }
        .padding(.all)
        .foregroundStyle(Color.white)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(
                    {
                        switch action {
                        case .start:
                            Color.green
                        case .pause:
                            Color.yellow
                        case .reset:
                            Color.red
                        }
                    }()
                )
        )
    }
}

#Preview {
    StopwatchView()
}
