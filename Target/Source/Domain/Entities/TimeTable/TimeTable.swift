
struct TimeTable: Codable {
    let subjects: [TimeTable.Subject]
    
    struct Subject: Codable {
        let name: String
        let period: Int
    }
}
