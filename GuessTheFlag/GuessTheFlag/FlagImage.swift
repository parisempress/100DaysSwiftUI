
import SwiftUI

struct FlagImage: View {
    let name: String

    var body: some View {
        Image(name)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

#Preview {
    FlagImage(name: "France")
}
