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
            state = .secondStep
//            try? await Task.sleep(for: Duration.seconds(5))
            self.state = .finished
        }
    }
    
}
