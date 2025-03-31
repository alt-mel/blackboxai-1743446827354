import SwiftUI

@main
struct SleepTrackerApp: App {
    @StateObject private var sleepDataManager = SleepDataManager()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
            }
            .environmentObject(sleepDataManager)
        }
    }
}