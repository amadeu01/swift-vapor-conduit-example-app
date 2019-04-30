import Vapor
import FluentPostgreSQL
import Fluent

final class Article: PostgreSQLModel {
    var id: Int?
    
    init(id: Int? = nil) {
        self.id = id
    }
}

extension Article: Content {}
extension Article: Migration {}
extension Article: Parameter {}
