import SwiftUI

struct OnboardingView: View {
    @Binding var hasFinishedOnboarding: Bool
    
    var body: some View {
       
        FolkScreenWrapper {
            TabView {
                OnboardingPage(
                    iconName: "eye.slash",
                    iconColor: .purple,
                    title: "Languages exist.\nBut not all are seen.",
                    bodyText: "1 in 10 Indigenous-language-speaking children attend school without speaking the dominant language.\n— UNESCO",
                    footerText: "In many classrooms, local languages remain invisible.",
                    isLastPage: false,
                    action: {}
                )
                
                OnboardingPage(
                    iconName: "person.2.slash",
                    iconColor: .orange,
                    title: "When a language is invisible, children feel invisible.",
                    bodyText: "In schools near Otomí communities, classrooms are dominated by Spanish and English. Otomí rarely appears in everyday learning spaces.",
                    footerText: "This reduces recognition, belonging, and respect for the language.",
                    isLastPage: false,
                    action: {}
                )
                
                OnboardingPage(
                    iconName: "arkit",
                    iconColor: .green,
                    title: "Meet Bätsi.",
                    bodyText: "A markerless AR app that transforms classroom objects into trilingual learning experiences.\n\nChildren place Otomí–Spanish–English labels in the real world, creating shared moments where every language is equally visible.",
                    footerText: "Not to teach a language.\nTo recognize it.",
                    isLastPage: true,
                    action: {
                        withAnimation(.spring()) {
                            hasFinishedOnboarding = true
                        }
                    }
                )
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .background(Color.batsiBackground)
        }
    }
}


struct OnboardingPage: View {
    let iconName: String
    let iconColor: Color
    let title: String
    let bodyText: String
    let footerText: String
    let isLastPage: Bool
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            Image(systemName: iconName)
                .font(.system(size: 80))
                .foregroundColor(iconColor)
            
            Text(title)
                .font(.system(size: 32, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text(bodyText)
                .font(.title3)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal, 30)
            
            Text(footerText)
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundColor(iconColor)
                .padding(.horizontal, 30)
            
            Spacer()
            
            if isLastPage {
                Button(action: action) {
                    Text("Start Exploring")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(iconColor)
                        .cornerRadius(15)
                        .padding(.horizontal, 40)
                }
                .padding(.bottom, 60)
            } else {
                Spacer().frame(height: 80)
            }
        }
    }
}
