import SwiftUI

struct ProfileDetail: View {
    var individual: FetchedResults<Individual>.Element

    let name: String

    enum Affiliation: String {
        case jedi = "JEDI"
        case resistance = "RESISTANCE"
        case firstOrder = "FIRST_ORDER"
        case sith = "SITH"
    }

    var body: some View {
        if let profilePicture = individual.profilePicture,
           let birthdate = individual.birthdate,
           let affiliation = individual.affiliation {
            VStack {
                AsyncImage(url: URL(string: profilePicture)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                    .aspectRatio(contentMode: .fit)

                VStack(alignment: .leading) {
                    Label("Born on \(formatBirthdate(date: birthdate))", systemImage: "gift")

                    if let affiliation = Affiliation(rawValue: affiliation) {
                        switch affiliation {
                        case .jedi:
                            Label("Jedi", systemImage: "rays")
                        case .resistance:
                            Label("Resistance", systemImage: "shield")
                        case .firstOrder:
                            Label("First Order", systemImage: "building.columns")
                        case .sith:
                            Label("Sith", systemImage: "brain")
                        }
                    }

                    if individual.forceSensitive {
                        Label("Force Sensitive", systemImage: "bolt")
                    }
                }
                    .padding()
            }
                .navigationTitle(name)
        }
    }
}
