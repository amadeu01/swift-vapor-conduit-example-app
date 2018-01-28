import Vapor
import FluentPostgreSQL
import Fluent

final class FollowersAssoc: ModifiablePivot {
    typealias Database = PostgreSQLDatabase
    public typealias ID = Int
    public typealias Left = Profile
    public typealias Right = Profile
    
    public static var idKey: IDKey {
        return \.id
    }
    
    public static var leftIDKey: LeftIDKey {
        return \.followerId
        
    }

    public static var rightIDKey: RightIDKey {
        return \.followedById
    }
    
    var id: Int?
    var followerId: Int
    var followedById: Int
    
    init(_ follower: Profile, _ followedBy: Profile) throws {
        self.followerId = try follower.requireID()
        self.followedById = try followedBy.requireID()
    }
}

extension FollowersAssoc: Migration {
    
    static func prepare(on connection: Database.Connection) -> Future<Void> {
        return Database.create(FollowersAssoc.self, on: connection) { builder in
            try builder.field(for: \FollowersAssoc.id)
            try builder.field(for: \FollowersAssoc.followerId)
            try builder.field(for: \FollowersAssoc.followedById)
        }
    }
    
    static func revert(on connection: Database.Connection) -> Future<Void> {
        return Database.delete(FollowersAssoc.self, on: connection)
    }
}
