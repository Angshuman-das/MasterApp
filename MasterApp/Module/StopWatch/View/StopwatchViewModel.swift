//
//  StopwatchViewModel.swift
//  MasterApp
//
//  Created by Angshuman on 11/02/26.
//

import Foundation
import Combine

enum ButtonAction: String, CaseIterable {
    case start = "Play"
    case pause = "Pause"
    case reset = "Reset"
}

protocol StopwatchViewModelProtocol: ObservableObject {
    var timerText: String { get }
    
    func startStopWatch()
    func pauseStopwatch(isResumeable: Bool)
    func resetStopwatch()
}

final class StopwatchViewModel: StopwatchViewModelProtocol {
    @Published var timerText: String = ""
    
    private var isRunning: Bool = false
    private var time: TimeInterval = 0
    private var timer: AnyCancellable?
    
    init() {
        self.timerText = self.getTimeString()
    }
    
    func startStopWatch() {
        guard !isRunning else { return }
        isRunning = true
        
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { [weak self] _ in
                guard let self else {
                    return
                }
                
                self.getStopwatchTime(shouldReset: false)
            })
    }
    
    func pauseStopwatch(isResumeable: Bool = true) {
        guard isRunning else {
            return
        }
        
        defer {
            isRunning = false
        }
        
        timer?.cancel()
        
        if !isResumeable {
            timer = nil
        }
    }
    
    func resetStopwatch() {
        getStopwatchTime(shouldReset: true)
        pauseStopwatch(isResumeable: false)
    }
}

extension StopwatchViewModel {
    func getStopwatchTime(shouldReset: Bool) {
        addTotalSeconds(isReset: shouldReset)
        timerText = getTimeString(stopwatchTime: time)
    }
    
    func getTimeString(stopwatchTime: TimeInterval = 0) -> String {
        let totalSeconds = Int(stopwatchTime)
        
        let hour = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        
        return String(format: "%02d:%02d:%02d", hour, minutes, seconds)
    }
    
    func addTotalSeconds(isReset: Bool = false) {
        time = isReset ? 0 : (time + 1)
    }
}
