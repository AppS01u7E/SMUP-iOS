import Foundation

struct SignupRequest: Codable {
    let birth: String
    let emailToken: String
    let gender: User.Gender
    let password: String
    let dept: Dept
    let grade: Int
    let classNum: Int
    let number: Int
    let ent: Int
}
