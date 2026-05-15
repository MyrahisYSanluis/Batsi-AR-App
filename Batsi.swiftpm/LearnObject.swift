import SwiftUI

enum Category: String, CaseIterable {
    case school = "School / skuela, ngunsadi"
    case games = "Games / nt'eni"
    case food = "Food / hñuni, ntsi"
    
    var color: Color {
        switch self {
        case .school: return Color(red: 0.20, green: 0.55, blue: 0.56)
        case .games: return Color(red: 0.37, green: 0.56, blue: 0.21)
        case .food: return Color(red: 0.89, green: 0.36, blue: 0.35)
        }
    }
}

struct LearnObject: Identifiable, Equatable {
    let id = UUID()
    let category: Category
    let spanish: String
    let hnahnu: String
    let english: String
    let audioFileName: String
    let model3DName: String
    let imageName: String
}


let allObjects: [LearnObject] = [
    // SCHOOL
    LearnObject(category: .school, spanish: "Libro", hnahnu: "Mfixụnt'ot'i", english: "Book", audioFileName: "book", model3DName: "book", imageName: "book.closed"),
    LearnObject(category: .school, spanish: "Puerta", hnahnu: "Gosthi", english: "Door", audioFileName: "audio_door", model3DName: "door", imageName: "door.left.hand.closed"),
    LearnObject(category: .school, spanish: "Mesa", hnahnu: "Mexa", english: "Table", audioFileName: "audio_table", model3DName: "table", imageName: "table.furniture"),
    
    // GAMES
    LearnObject(category: .games, spanish: "Trompo", hnahnu: "Trompo", english: "Trompo", audioFileName: "audio_trompo", model3DName: "trompo", imageName: "tornado"),
    LearnObject(category: .games, spanish: "Pelota", hnahnu: "Nuni", english: "Ball", audioFileName: "audio_ball", model3DName: "ball", imageName: "soccerball"),
    LearnObject(category: .games, spanish: "Juguete", hnahnu: "nt'eni", english: "Toy", audioFileName: "audio_toy", model3DName: "toy", imageName: "teddybear"),
    
    // FOOD
    LearnObject(category: .food, spanish: "Chocolate", hnahnu: "dẹjụ", english: "Chocolate", audioFileName: "audio_chocolate", model3DName: "chocolate", imageName: "square.fill"),
    LearnObject(category: .food, spanish: "Tortilla", hnahnu: "Hme", english: "Tortilla", audioFileName: "audio_tortilla", model3DName: "tortilla", imageName: "circle.circle"),
    LearnObject(category: .food, spanish: "Naranja", hnahnu: "nanxa", english: "Orange", audioFileName: "audio_orange", model3DName: "orange", imageName: "circle.fill"),
    
]
