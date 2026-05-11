import SwiftUI

@main
struct Assignment_3App: App {
    init() {
        NotificationManager.shared.requestPermission()
        NotificationManager.shared.scheduleDailyReminder()
    }
    
    var body: some Scene {
        WindowGroup {
            TitleScreenView()
        }
    }
}
