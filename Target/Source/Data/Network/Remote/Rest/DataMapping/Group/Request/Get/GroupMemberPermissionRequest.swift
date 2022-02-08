import Foundation


struct GroupMemberPermissionRequest {
    let groupId: UUID
    let userId: UUID
    let permission: GroupMember.Permission
}
