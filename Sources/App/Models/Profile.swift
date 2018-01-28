import Vapor
import FluentPostgreSQL
import Fluent

final class Profile: Content {
    var id: Int?
    let userId: User.ID
    
    init(id: Int? = nil, userId: User.ID) {
        self.id = id
        self.userId = userId
    }
}

extension Profile: Model {
    public static var entity: String {
        return "profile"
    }
    
    static var idKey: IDKey {
        return \.id
    }
    
    typealias Database = PostgreSQLDatabase
    typealias ID = Int
}

extension Profile: Migration {
    static func prepare(on connection: Database.Connection) -> Future<Void> {
        return Database.create(Profile.self, on: connection) { builder in
            try builder.field(for: \Profile.id)
            try builder.field(for: \Profile.userId)
        }
    }

    static func revert(on connection: Database.Connection) -> Future<Void> {
        return Database.delete(Profile.self, on: connection)
    }
}

extension Profile {
    var user: Parent<Profile, User> {
        return parent(\.userId)
    }
}

extension Profile {
    var follows: Siblings<Profile, Profile, FollowersAssoc> {
        return siblings(FollowersAssoc.rightIDKey, FollowersAssoc.leftIDKey)
    }
}
