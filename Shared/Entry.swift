import SwiftUI

@main
struct Entry: App {
    let persistence = Persistence.shared

    var body: some Scene {
        WindowGroup {
            Root()
                .environment(\.managedObjectContext, persistence.container.viewContext)
        }
    }
}
