import SwiftUI

struct ARExplorerView: View {
    let category: Category
    @Environment(\.dismiss) var dismiss
    
    
    var categoryObjects: [LearnObject] {
        allObjects.filter { $0.category == category }
    }
    
    // Estados para controlar la selección y la colocación en AR
    @State private var selectedObject: LearnObject?
    @State private var placeTrigger = false
    
    var body: some View {
        ZStack {
            // 1. LA CÁMARA AR
            ARViewContainer(
                selectedObject: $selectedObject,
                shouldPlace: $placeTrigger,
                categoryColor: category.color
            )
            .edgesIgnoringSafeArea(.all)
            
            // 2. INTERFAZ DE USUARIO
            VStack {
                
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "arrow.left.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.white)
                            .shadow(radius: 5)
                    }
                    Spacer()
                    Text(category.rawValue)
                        .font(.headline)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 8)
                        .background(.ultraThinMaterial)
                        .cornerRadius(12)
                }
                .padding(.top, 40)
                .padding(.horizontal)
                
                Spacer()
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(categoryObjects) { object in
                            Button(action: {
                                selectedObject = object
                                
                                
                            }) {
                                VStack {
                                    Image(systemName: object.imageName)
                                        .font(.system(size: 25))
                                    Text(object.english)
                                        .font(.caption2).bold()
                                }
                                .padding()
                                .frame(width: 90, height: 90)
                                .background(selectedObject == object ? Color.white : .black.opacity(0.5))
                                .foregroundColor(selectedObject == object ? category.color : .white)
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.white, lineWidth: selectedObject == object ? 3 : 0)
                                )
                            }
                        }
                    }
                    .padding()
                }
                
                
                if let obj = selectedObject {
                    Button(action: {
                        placeTrigger = true
                       
                    }) {
                        HStack {
                            Image(systemName: "plus.viewfinder")
                            Text("Place/Colocar \(obj.hnahnu.uppercased())")
                        }
                        .font(.headline.bold())
                        .foregroundColor(.white)
                        .padding(.vertical, 15)
                        .padding(.horizontal, 30)
                        .background(category.color)
                        .cornerRadius(25)
                        .shadow(radius: 10)
                    }
                    .padding(.bottom, 30)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            
            if selectedObject == nil {
                selectedObject = categoryObjects.first
            }
        }
    }
}
