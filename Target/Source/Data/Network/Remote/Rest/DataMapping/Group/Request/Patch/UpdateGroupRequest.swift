
struct UpdateGroupRequest: Codable {
    let id: String
    let name: String
    let description: String
    let type: UpdateGroupRequest.`Type`
    
    enum `Type`: String, Codable {
        case clubMajor = "CLUB_MAJOR"
        case clubCa = "CLUB_CA"
        case clubEtc = "CLUB_ETC"
        case team = "TEAM"
    }
}
