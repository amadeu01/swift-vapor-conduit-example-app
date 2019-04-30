import Vapor
import FluentPostgreSQL

final class Comment: PostgreSQLModel {
    var id: Int?
    
    init(id: Int? = nil) {
        self.id = id
    }
}

extension Comment: Content {}
extension Comment: Migration {}

