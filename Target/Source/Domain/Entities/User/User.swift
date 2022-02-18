import Foundation


struct User: Codable {
    let id: String
    let email: String
    let name: String
    let gender: User.Gender
    let createdAt: Date
    let profilePhoto: String
    let birth: String
    let school: School
    
    enum Gender: String, Codable {
        case male = "남"
        case female = "여"
    }
}
