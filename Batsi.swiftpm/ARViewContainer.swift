import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: UIViewRepresentable {
    @Binding var selectedObject: LearnObject?
    @Binding var shouldPlace: Bool
    let categoryColor: Color
    
    @MainActor
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        arView.session.run(config)
        
        return arView
    }
    
    @MainActor
    func updateUIView(_ uiView: ARView, context: Context) {
            if shouldPlace, let object = selectedObject {
                
                
                uiView.scene.anchors.removeAll()
                
                
                let uiColor = UIColor(categoryColor)
                let entity = ARLabelManager.createObject(for: object, color: uiColor)
                
                
                let anchor = AnchorEntity(world: [0, 0, -0.5])
                anchor.addChild(entity)
                uiView.scene.addAnchor(anchor)
                
                
                DispatchQueue.main.async {
                    shouldPlace = false
                }
            }
        }
}
