import Foundation


struct User: Codable {
    let id: UUID
    let email: String
    let firstName: String
    let lastName: String
    let gender: User.Gender
    let grade: Int
    let birth: String
    
    enum Gender: String, Codable {
        case male = "남"
        case female = "여"
    }
}
