//
//  InstallView.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-04.
//

import SwiftUI
import SwiftData

struct InstallView: View {
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager
//    @Environment(\.modelContext) private var modelContext
    @State private var msg: String = ""

    private let timer = Timer.publish(every: 0.1, on: .current, in: .default).autoconnect()

    var body: some View {
        VStack {
            Text("Loading").fontWeight(.bold).font(.headline)
            Text(msg).font(.subheadline)
        }.onAppear {
            updateStatusMessage()
//            checkFirstInstall(context: modelContext)
        }.onReceive(timer){
            timer in
                print("Received timer in launch screen")
                updateStatusMessage()
                checkOnContentService()
        }
    }
    
    private func updateStatusMessage(){
        print("before state check:", msg)
        switch launchScreenState.state {
        case .firstStep:
            msg = "Starting."
        case .secondStep:
            msg = "Installing data."
        case .finished:
            msg = "Done."
            break
        }
        print("after state check:", msg)
    }
    
    private func checkOnContentService() {
        switch ContentService.shared.itemManager.items.count {
        case 0:
            launchScreenState.setFirstStep()
        case 1...10:
            launchScreenState.setSecondStage()
        case 300...600:
            launchScreenState.dismiss()
        default:
            break
        }
    }
    
    private func checkFirstInstall(context: ModelContext)-> Void {
        let firstInstalledKey = "firstInstalled"
        let defaults = UserDefaults.standard
        let firstInstalled = defaults.bool(forKey: firstInstalledKey)

        if !firstInstalled {
            defaults.set(true, forKey: firstInstalledKey)
            SetConstants(with: context).setClubs()
        }
        self.launchScreenState.dismiss()
    }
}

#Preview {
    InstallView().environment(LaunchScreenStateManager())
}
