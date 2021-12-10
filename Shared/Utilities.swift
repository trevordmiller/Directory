import Foundation

func formatBirthdate(date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    let converted = dateFormatter.date(from: date)
    
    guard dateFormatter.date(from: date) != nil else {
        return ""
    }
    
    dateFormatter.dateFormat = "MM/dd/yyyy"
    
    if let converted = converted {
        let formatted = dateFormatter.string(from: converted)
        return formatted
    } else {
        return ""
    }
}

func combineNames(firstName: String, lastName: String) -> String {
    return lastName.isEmpty ? firstName : "\(firstName) \(lastName)"
}
