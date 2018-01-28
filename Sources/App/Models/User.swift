import Vapor
import FluentPostgreSQL
import Fluent
import Foundation
import Crypto

final class User: Content, Timestampable {
    var id: Int?
    let email: String
    let username: String
    var hash: String
    var password: String? {
        set {
            let salt: Data = OSRandom().data(count: 32)
            let data = try! PBKDF2<SHA256>.deriveKey(fromPassword: newValue as String!, saltedWith: salt)
            self.hash = String(bytes: data, encoding: .utf8)!
        }
        get {
            return hash
        }
    }
    let bio: String
    let image: String
    public var createdAt: Date?
    public var updatedAt: Date?
    
    init(id: Int? = nil, username: String, hash: String, email: String, bio: String, image: String) {
        self.id = id
        self.username = username
        self.hash = hash
        self.email = email
        self.bio = bio
        self.image = image
    }
}

extension User: Model {
    public static var entity: String {
        return "user"
    }
    
    static var idKey: IDKey {
        return \.id
    }
    
    typealias Database = PostgreSQLDatabase
    typealias ID = Int
}

extension User: Migration {
    static func prepare(on connection: Database.Connection) -> Future<Void> {
        return Database.create(User.self, on: connection) { builder in
            try builder.field(for: \User.id)
            try builder.field(for: \User.username)
            try builder.field(for: \User.hash)
            try builder.field(for: \User.email)
            try builder.field(for: \User.bio)
            try builder.field(for: \User.image)
            try builder.field(for: \User.createdAt)
            try builder.field(for: \User.updatedAt)
        }
    }
    
    static func revert(on connection: Database.Connection) -> Future<Void> {
        return Database.delete(FollowersAssoc.self, on: connection)
    }
}
