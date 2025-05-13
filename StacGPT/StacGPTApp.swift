//
//  StacGPTApp.swift
//  StacGPT
//
//  Created by Bitania yonas on 4/6/25.
//

import SwiftUI

@main
struct StacGPTApp: App {
    @State private var isShowingLaunchScreen = true
    
    var body: some Scene {
        WindowGroup {
            if isShowingLaunchScreen {
                LaunchScreen()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                isShowingLaunchScreen = false
                            }
                        }
                    }
            } else {
                ContentView()
            }
        }
    }
} 
