import Foundation
import RealityKit
import UIKit
import AVFoundation

@MainActor
class ARLabelManager {
    
    static let synthesizer = AVSpeechSynthesizer()
    
    static func createObject(for object: LearnObject, color: UIColor) -> Entity {
        let parentEntity = Entity()
        let size: Float = 0.2
        
        print("🏗️ Construyendo cubo manual para: \(object.spanish)")
        
        let baseName = object.model3DName
        
        
        let faces: [(suffix: String, pos: SIMD3<Float>, rotAngle: Float, rotAxis: SIMD3<Float>)] = [
            ("_front",  [0, 0, size/2],  0,        [0, 1, 0]),
            ("_back",   [0, 0, -size/2], .pi,      [0, 1, 0]),
            ("_right",  [size/2, 0, 0],  .pi/2,    [0, 1, 0]),
            ("_left",   [-size/2, 0, 0], -.pi/2,   [0, 1, 0]),
            ("_top",    [0, size/2, 0],  -.pi/2,   [1, 0, 0]),
            ("_bottom", [0, -size/2, 0], .pi/2,    [1, 0, 0])
        ]
        
        for face in faces {
            let imageName = "\(baseName)\(face.suffix)"
            let mesh = MeshResource.generatePlane(width: size, height: size)
            let materialInfo = createTextureMaterial(imageName: imageName, fallbackColor: color)
            
            let faceEntity = ModelEntity(mesh: mesh, materials: [materialInfo.mat])
            faceEntity.position = face.pos
            faceEntity.orientation = simd_quatf(angle: face.rotAngle, axis: face.rotAxis)
            parentEntity.addChild(faceEntity)
        }
        
        
        let objectHeight = size / 2
        var currentY: Float = objectHeight + 0.05
        
        let english = generate3DText(text: object.english, size: 0.02, color: .cyan)
        english.position.y = currentY
        parentEntity.addChild(english)
        currentY += 0.04
        
        let spanish = generate3DText(text: object.spanish, size: 0.03, color: .yellow)
        spanish.position.y = currentY
        parentEntity.addChild(spanish)
        currentY += 0.06
        
        let hnahnu = generate3DText(text: object.hnahnu, size: 0.05, color: .white)
        hnahnu.position.y = currentY
        parentEntity.addChild(hnahnu)
        
        
        reproducirSecuenciaDeAudio(for: object)
        
        return parentEntity
    }
    
    // --- LÓGICA DE AUDIO ---
    
    static func reproducirSecuenciaDeAudio(for object: LearnObject) {
        
        synthesizer.stopSpeaking(at: .immediate)
        
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
            let utteranceES = AVSpeechUtterance(string: object.spanish)
            utteranceES.voice = AVSpeechSynthesisVoice(language: "es-MX")
            utteranceES.rate = 0.45
            
            let utteranceEN = AVSpeechUtterance(string: object.english)
            utteranceEN.voice = AVSpeechSynthesisVoice(language: "en-US")
            utteranceEN.rate = 0.45
            
            synthesizer.speak(utteranceES)
            synthesizer.speak(utteranceEN)
        }
    }
    
    
    
    private static func createTextureMaterial(imageName: String, fallbackColor: UIColor) -> (mat: Material, isFallback: Bool) {
        if let texture = try? TextureResource.load(named: imageName) {
            var material = SimpleMaterial()
            material.color = .init(texture: MaterialParameters.Texture(texture))
            return (material, false)
        } else {
            return (SimpleMaterial(color: fallbackColor.withAlphaComponent(0.8), isMetallic: false), true)
        }
    }
    
    private static func generate3DText(text: String, size: Float, color: UIColor) -> ModelEntity {
        let mesh = MeshResource.generateText(text, extrusionDepth: 0.005, font: .systemFont(ofSize: CGFloat(size), weight: .bold), containerFrame: .zero, alignment: .center, lineBreakMode: .byTruncatingTail)
        let material = UnlitMaterial(color: color)
        let entity = ModelEntity(mesh: mesh, materials: [material])
        let bounds = entity.visualBounds(relativeTo: nil)
        entity.position.x = -(bounds.extents.x / 2)
        return entity
    }
}
