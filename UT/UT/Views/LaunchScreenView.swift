//
//  InstallView.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-04.
//

import SwiftUI
import SwiftData

struct LaunchScreenView: View {
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager
//    @Environment(\.modelContext) private var modelContext
    @State private var msg: String = ""

    private let timer = Timer.publish(every: 0.25, on: .current, in: .default).autoconnect()

    var body: some View {
        HStack{
            VStack {
                Spacer()
                Image(systemName: "soccerball.inverse").resizable().aspectRatio(contentMode: .fit).font(.largeTitle).padding(115).foregroundStyle(Color.white)
                Text("Loading").fontWeight(.bold).font(.largeTitle).foregroundStyle(Color.white)
                Spacer()
                Spacer()
            }.onAppear {
//                updateStatusMessage()
                checkOnContentService()
//                checkFirstInstall(context: modelContext)
            }.onReceive(timer){
                timer in

//                updateStatusMessage()
                checkOnContentService()
            }
        }

        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(hexStr: "09B030"),
                                                       Color(hexStr: "0B720B"),
                                                       Color(hexStr: "0B3628")] ), startPoint: .topLeading, endPoint: .bottomTrailing))
    }
    
    private func updateStatusMessage(){
        switch launchScreenState.state {
        case .firstStep:
            msg = "Starting."
        case .secondStep:
            msg = "Downloading data."
        case .finished:
            msg = "Done."
            break
        }
    }
    
    private func checkOnContentService() {
        switch ContentService.shared.itemManager.items.count {
        case 0:
            launchScreenState.setFirstStep()
        case 100...299:
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
//            SetConstants(with: context).setClubs()
        }
        self.launchScreenState.dismiss()
    }
}

#Preview {
    LaunchScreenView().environment(LaunchScreenStateManager())
}
