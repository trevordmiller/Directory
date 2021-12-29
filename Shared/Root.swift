import SwiftUI
import CoreData

struct Root: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Individual.externalId, ascending: true)],
        animation: .default)
    private var individuals: FetchedResults<Individual>

    enum DownloadPhases {
        case progress
        case fail
        case success
    }

    @State private var downloadPhase = DownloadPhases.progress

    func download() {
        Task {
            do {
                let hasRenderableIndividuals = individuals
                    .filter({ $0.firstName != nil })
                    .count > 0

                if hasRenderableIndividuals {
                    downloadPhase = DownloadPhases.success
                } else {
                    downloadPhase = DownloadPhases.progress

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

                    downloadPhase = DownloadPhases.success
                }
            } catch {
                downloadPhase = DownloadPhases.fail
            }
        }
    }

    var body: some View {
        switch downloadPhase {
        case .progress:
            ProgressView()
                .onAppear {
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

struct Root_Previews: PreviewProvider {
    static var previews: some View {
        Root()
            .environment(\.managedObjectContext, Persistence.preview.container.viewContext)
    }
}
