import SwiftUI

struct WelcomeView: View {
    @AppStorage("currentSession") var currentSession: Int = 0
    @State private var navigateToCategories = false
    
    var body: some View {
        
        FolkScreenWrapper {
            
            NavigationStack {
                ZStack {
                    Color.batsiBackground.ignoresSafeArea()
                    
                    VStack(spacing: 40) {
                        Spacer()
                        Image(systemName: "bird.fill")
                            .resizable().scaledToFit().frame(width: 120, height: 120)
                            .foregroundColor(.orange)
                        
                        Text("Bätsi")
                            .font(.system(size: 70, weight: .bold, design: .rounded))
                            .foregroundColor(.black)
                        
                        Text("Making visible the invisible / Hacer visible lo invisible")
                            .font(.title3).foregroundColor(.gray)
                        
                        Spacer()
                        
                        Button(action: {
                            if currentSession == 0 { currentSession = 1 }
                            navigateToCategories = true
                        }) {
                            Text(currentSession == 0 ? "Start / Comenzar" : "Continue Session / Continuar Sesión \(currentSession)")
                                .font(.title2).bold().frame(maxWidth: .infinity).padding()
                                .background(Color.orange).foregroundColor(.white).cornerRadius(20)
                        }
                        .padding(.horizontal, 50)
                        
                        .navigationDestination(isPresented: $navigateToCategories) {
                            CategorySelectionView()
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}
