import Vapor
import FluentPostgreSQL
import Fluent

final class Article: Content {
    var id: Int?
    
    init(id: Int? = nil) {
        self.id = id
    }
}

extension Article: Model {
    public static var entity: String {
        return "article"
    }
    
    static var idKey: IDKey {
        return \.id
    }
    
    typealias Database = PostgreSQLDatabase
    typealias ID = Int
}

extension Article: Migration {
    static func prepare(on connection: Database.Connection) -> Future<Void> {
        return Database.create(Article.self, on: connection) { builder in
            try builder.field(for: \Article.id)
        }
    }
    
    static func revert(on connection: Database.Connection) -> Future<Void> {
        return Database.delete(Article.self, on: connection)
    }
}
