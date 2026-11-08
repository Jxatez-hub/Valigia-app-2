import SwiftUI

@main
struct ValigiaApp: App {
    @StateObject private var store = PackingStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
