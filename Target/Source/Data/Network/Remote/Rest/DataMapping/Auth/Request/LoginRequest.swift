

struct LoginRequest: Codable {
    let deviceToken: String
    let email: String
    let password: String
}
