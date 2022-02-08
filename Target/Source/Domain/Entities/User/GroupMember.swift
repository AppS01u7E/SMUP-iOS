import Foundation


struct GroupMember: Codable {
    let userId: UUID
    let joinedAt: Date
    let permission: GroupMember.Permission
    let recent10Posts: [UUID]
    let recent10Comments: [UUID]
    
    enum Permission: String, Codable {
        case student = "STUDENT"
        case `operator` = "OPERATOR"
        case teacher = "TEACHER"
        case owner = "OWNER"
    }
}
