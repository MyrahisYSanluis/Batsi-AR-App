import SwiftUI

struct CategorySelectionView: View {
    let categories = Category.allCases
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Choose a category/Elige una categoría")
                    .font(.largeTitle.bold())
                    .padding()
                
                ForEach(categories, id: \.self) { cat in
                    NavigationLink(destination: ARExplorerView(category: cat)) {
                        HStack {
                            Text(cat.rawValue)
                                .font(.title.bold())
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .padding(30)
                        .background(cat.color)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}
