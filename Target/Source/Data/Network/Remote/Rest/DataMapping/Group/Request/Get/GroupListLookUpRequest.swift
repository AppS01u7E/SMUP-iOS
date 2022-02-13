

struct GroupListLookUpRequest: Codable {
    let idx: Int
    let size: Int
    let type: GroupListLookUpRequest.`Type`
    
    enum `Type`: String, Codable {
        case all = "ALL"
        case my = "MY"
        case req = "REQ"
    }
}

