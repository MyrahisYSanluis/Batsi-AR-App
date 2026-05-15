import SwiftUI


struct FolkScreenWrapper<Content: View>: View {
    
    let content: Content

    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack {
            
            Color(red: 247/255, green: 243/255, blue: 235/255)
                .ignoresSafeArea()

            
            Image("folkImage")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .opacity(0.85)

            
            content
                
                .padding(EdgeInsets(top: 0, leading: 100, bottom: 0, trailing: 100))
        }
    }
}
