import SwiftUI

struct ProfileBrowse: View {
    var individuals: FetchedResults<Individual>

    var body: some View {
        List(individuals) { individual in
            if let profilePicture = individual.profilePicture,
               let firstName = individual.firstName,
               let lastName = individual.lastName {
                let name = combineNames(firstName: firstName, lastName: lastName)
                NavigationLink(destination: ProfileDetail(individual: individual, name: name)) {
                    HStack {
                        AsyncImage(url: URL(string: profilePicture)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .cornerRadius(5)

                        Text(name)
                    }
                }
            }
        }
            .navigationTitle("Browse")
    }
}
