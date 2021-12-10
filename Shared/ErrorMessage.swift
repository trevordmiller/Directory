import SwiftUI

struct ErrorMessage: View {
    let description: String
    
    var body: some View {
        VStack {
            Label("Error", systemImage: "exclamationmark.triangle.fill")
                .font(.title)
                .foregroundColor(.red)
                .padding()
            
            Text(description)
                .foregroundColor(.secondary)
        }
            .padding()
    }
}

struct ErrorMessage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ErrorMessage(description: "That didn't work!")
            
            ErrorMessage(description: "That didn't work!")
                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
                .previewDisplayName("Dynamic Type")
        }
    }
}
