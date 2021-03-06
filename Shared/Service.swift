import Foundation

struct Service {
    enum ServiceError: Error {
        case brokenURL
        case missingData
    }

    struct IndividualResult: Codable, Identifiable {
        let id: Int32
        let firstName: String
        let lastName: String
        let birthdate: String
        let profilePicture: String
        let forceSensitive: Bool
        let affiliation: String
    }

    struct RootResults: Codable {
        let individuals: [IndividualResult]
    }

    func getIndividuals() async throws -> [IndividualResult] {
        guard let url = URL(string: "https://edge.ldscdn.org/mobile/interview/directory") else {
            throw ServiceError.brokenURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        if data.isEmpty {
            throw ServiceError.missingData
        }

        let rootResults = try JSONDecoder().decode(RootResults.self, from: data)
        return rootResults.individuals
    }
}

// Sample data
/*
 {
   "individuals": [
     {
       "id":1,
       "firstName":"Luke",
       "lastName":"Skywalker",
       "birthdate":"1963-05-05",
       "profilePicture":"https://edge.ldscdn.org/mobile/interview/07.png",
       "forceSensitive":true,
       "affiliation":"JEDI"
     },
     {
       "id":2,
       "firstName":"Leia",
       "lastName":"Organa",
       "birthdate":"1963-05-05",
       "profilePicture":"https://edge.ldscdn.org/mobile/interview/06.png",
       "forceSensitive":true,
       "affiliation":"RESISTANCE"
     },
     {
       "id":3,
       "firstName":"Han",
       "lastName":"Solo",
       "birthdate":"1956-08-22",
       "profilePicture":"https://edge.ldscdn.org/mobile/interview/04.png",
       "forceSensitive":false,
       "affiliation":"RESISTANCE"
     },
     {
       "id":4,
       "firstName":"Chewbacca",
       "lastName":"",
       "birthdate":"1782-11-15",
       "profilePicture":"https://edge.ldscdn.org/mobile/interview/01.png",
       "forceSensitive":false,
       "affiliation":"RESISTANCE"
     },
     {
       "id":5,
       "firstName":"Kylo",
       "lastName":"Ren",
       "birthdate":"1987-10-31",
       "profilePicture":"https://edge.ldscdn.org/mobile/interview/05.jpg",
       "forceSensitive":true,
       "affiliation":"FIRST_ORDER"
     },
     {
       "id":6,
       "firstName":"Supreme Leader",
       "lastName":"Snoke",
       "birthdate":"1947-01-01",
       "profilePicture":"https://edge.ldscdn.org/mobile/interview/08.jpg",
       "forceSensitive":true,
       "affiliation":"FIRST_ORDER"
     },
     {
       "id":7,
       "firstName":"General",
       "lastName":"Hux",
       "birthdate":"1982-07-04",
       "profilePicture":"https://edge.ldscdn.org/mobile/interview/03.png",
       "forceSensitive":false,
       "affiliation":"FIRST_ORDER"
     },
     {
       "id":8,
       "firstName":"Darth",
       "lastName":"Vader",
       "birthdate":"1947-07-13",
       "profilePicture":"https://edge.ldscdn.org/mobile/interview/02.jpg",
       "forceSensitive":true,
       "affiliation":"SITH"
     }
   ]
 }
 */
