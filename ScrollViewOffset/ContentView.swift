import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Read offset from ScrollView", destination: { OffsetReadingScrollView() })
                NavigationLink("Change view's opacity when scrolled", destination: { OpacityChangingSampleView() })
                NavigationLink("ScrollView with sticky header", destination: { StickyHeaderSampleView() })
            }
            .navigationTitle("ScrollViewOffset")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
