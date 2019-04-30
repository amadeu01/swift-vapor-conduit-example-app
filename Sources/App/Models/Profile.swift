import Vapor
import FluentPostgreSQL

final class Profile: PostgreSQLModel {
    var id: Int?
    let userId: User.ID
    
    init(id: Int? = nil, userId: User.ID) {
        self.id = id
        self.userId = userId
    }
    
    var user: Parent<Profile, User> {
        return parent(\.userId)
    }
    
    var follows: Siblings<Profile, Profile, FollowersAssoc> {
        return siblings(FollowersAssoc.rightIDKey, FollowersAssoc.leftIDKey)
    }
}

extension Profile: Content {}
extension Profile: Migration {}
