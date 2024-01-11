//
//  LaunchScreenStateManager.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-04.
//

import Foundation

final class LaunchScreenStateManager: ObservableObject, Observable {
    @MainActor
    @Published
    private(set) var state: LaunchScreenStep = .firstStep
    
    @MainActor
    func dismiss(){
        Task {
//            state = .secondStep
//            try? await Task.sleep(for: Duration.seconds(2))
            self.state = .finished
        }
    }
    
    @MainActor
    func setSecondStage() -> Void {
        Task{
            self.state = .secondStep
        }
    }
    
    @MainActor
    func setFirstStep() {
        Task {
            self.state = .firstStep
        }
    }
}
