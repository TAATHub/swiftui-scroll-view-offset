import SwiftUI

struct OpacityChangingSampleView: View {
    @State var items = Array(0..<50).map{ "\($0)"}
    @State private var offset: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(items, id: \.self) { item in
                        HStack(spacing: 16) {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                            
                            Text("item \(item)")
                            
                            Spacer()
                        }
                        .padding(16)
                    }
                }
                .background {
                    GeometryReader { proxy in
                        // 透明なViewを下に敷いて、ScrollViewの座標系におけるy座標の変化量を取得する
                        Color.clear.onChange(of: proxy.frame(in: .named("ScrollView")).minY) { _, offset in
                            self.offset = offset
                            print("offset: \(offset)")
                        }
                    }
                }
            }
            .coordinateSpace(name: "ScrollView")
            
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 64, height: 64)
                .foregroundStyle(.blue)
                .opacity(1 + (offset/500.0))
                .padding()
        }
        .navigationTitle("Change view's opacity when scrolled")
    }
}

#Preview {
    OpacityChangingSampleView()
}
