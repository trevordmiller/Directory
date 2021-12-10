import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Individual.externalId, ascending: true)],
        animation: .default)
    private var individuals: FetchedResults<Individual>
    
    enum DownloadStates {
        case progress
        case fail
        case success
    }
    
    @State private var downloadStates = DownloadStates.progress
    
    func download() {
        Task {
            do {
                let hasRenderableIndividuals = individuals
                    .filter({ $0.firstName != nil })
                    .count > 0
                
                if hasRenderableIndividuals {
                    self.downloadStates = DownloadStates.success
                } else {
                    self.downloadStates = DownloadStates.progress
                    
                    let service = Service()
                    
                    let individualResults = try await service.getIndividuals()
                        
                    for individualResult in individualResults {
                        let individual = Individual(context: viewContext)
                        individual.externalId = individualResult.id
                        individual.firstName = individualResult.firstName
                        individual.lastName = individualResult.lastName
                        individual.birthdate = individualResult.birthdate
                        individual.profilePicture = individualResult.profilePicture
                        individual.forceSensitive = individualResult.forceSensitive
                        individual.affiliation = individualResult.affiliation
                    }
                    
                    try viewContext.save()
                    
                    self.downloadStates = DownloadStates.success
                }
            } catch {
                self.downloadStates = DownloadStates.fail
            }
        }
    }
    
    var body: some View {
        switch downloadStates {
        case .progress:
            ProgressView()
                .onAppear() {
                    download()
                }
            
        case .fail:
            ErrorMessage(description: "The data wasn't able to download.")
            
        case .success:
            NavigationView {
                ProfileBrowse(individuals: individuals)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, Persistence.preview.container.viewContext)
    }
}
