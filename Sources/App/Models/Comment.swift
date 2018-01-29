import Vapor
import FluentPostgreSQL
import Fluent

final class Comment: Content {
    var id: Int?
    
    init(id: Int? = nil) {
        self.id = id
    }
}

extension Comment: Model {
    public static var entity: String {
        return "comment"
    }
    
    static var idKey: IDKey {
        return \.id
    }
    
    typealias Database = PostgreSQLDatabase
    typealias ID = Int
}

extension Comment: Migration {
    static func prepare(on connection: Database.Connection) -> Future<Void> {
        return Database.create(Comment.self, on: connection) { builder in
            try builder.field(for: \Comment.id)
        }
    }
    
    static func revert(on connection: Database.Connection) -> Future<Void> {
        return Database.delete(Comment.self, on: connection)
    }
}

