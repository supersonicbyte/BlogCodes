//
//  AppReadinessApp.swift
//  AppReadiness
//
//  Created by Mirza Učanbarlić on 17. 5. 2024..
//

import SwiftUI

@main
struct AppReadinessApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    // Simulating heavy work
                    try? await Task.sleep(for: .seconds(3))
                    AppReadiness.shared.setAppIsReady()
                    // Runs immidietly since app is ready
                    AppReadiness.shared.runSyncNowOrWhenAppBecomesReady {
                        print("Running immidietly")
                    }
                }
        }
    }
}

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        for i in 0...5 {
            AppReadiness.shared.runSyncNowOrWhenAppBecomesReady {
                print("Task \(i)")
                print("Scheduled task \(i) at: \(Date.now.formatted())")
            }
        }
        return true
    }
}
