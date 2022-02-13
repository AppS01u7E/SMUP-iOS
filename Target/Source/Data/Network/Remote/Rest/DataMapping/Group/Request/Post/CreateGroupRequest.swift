
struct CreateGroupRequest: Codable {
    let name: String
    let description: String
    let type: Soom.GroupType
}
