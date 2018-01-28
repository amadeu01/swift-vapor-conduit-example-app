import Vapor
import FluentPostgreSQL
import Fluent

final class Article: Content {
    var id: Int?
    
    init(id: Int? = nil) {
        self.id = id
    }
}
