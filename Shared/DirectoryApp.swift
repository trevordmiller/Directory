import SwiftUI

@main
struct DirectoryApp: App {
    let persistence = Persistence.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistence.container.viewContext)
        }
    }
}
