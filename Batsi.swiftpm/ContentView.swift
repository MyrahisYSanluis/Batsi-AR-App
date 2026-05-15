import SwiftUI

struct ContentView: View {
    @State private var hasFinishedIntro: Bool = false
    
    var body: some View {
        ZStack {
            if hasFinishedIntro {
                WelcomeView()
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
            } else {
                OnboardingView(hasFinishedOnboarding: $hasFinishedIntro)
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: hasFinishedIntro)
        .onAppear {
            
            hasFinishedIntro = false
        }
    }
}
