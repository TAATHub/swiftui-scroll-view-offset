import SwiftUI

struct StickyHeaderSampleView: View {
    @State var items = Array(0..<50).map{ "\($0)"}
    @State private var offset: CGFloat = 0
    @State private var sticked: Bool = false
    
    private let headerHeight: CGFloat = 150
    private let stickyHeaderHeight: CGFloat = 50
    private var topAreaHeight: CGFloat {
        headerHeight + stickyHeaderHeight
    }
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .top) {
                headerView(sticked: sticked)
                    .frame(maxWidth: .infinity)
                    .frame(height: sticked ? stickyHeaderHeight : topAreaHeight)
                    .background(sticked ? Color.red : Color.blue)
                    .zIndex(sticked ? 1 : 0)
                    .offset(y: -offset)
                
                LazyVStack(spacing: 0) {
                    ForEach(items, id: \.self) { item in
                        HStack(spacing: 16) {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                            
                            Text("item \(item)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(16)
                    }
                }
                .padding(.top, topAreaHeight)
                .background {
                    GeometryReader { backgroundProxy in
                        // 透明なViewを下に敷いて、ScrollViewの座標系におけるy座標の変化量を取得する
                        Color.clear.onChange(of: backgroundProxy.frame(in: .named("ScrollView")).minY) { _, newOffset in
                            if newOffset <= -headerHeight {
                                offset = newOffset
                                sticked = true
                            } else {
                                offset = 0
                                sticked = false
                            }
                            
                            print("newOffset: \(newOffset), offset: \(offset)")
                        }
                    }
                }
            }
        }
        .coordinateSpace(name: "ScrollView")
        .navigationTitle("ScrollView with sticky header")
    }
    
    @ViewBuilder
    private func headerView(sticked: Bool) -> some View {
        if sticked {
            HStack(spacing: 16) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                
                Text("テストテストテストテストテストテストテストテストテストテスト")
                    .frame(maxWidth: .infinity)
            }
            .padding(16)
        } else {
            VStack(spacing: 16) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                
                Text("テストテストテストテストテストテストテストテストテストテスト")
            }
            .padding(16)
        }
    }
}

#Preview {
    StickyHeaderSampleView()
}
