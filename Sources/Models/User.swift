import Vapor
import FluentPostgreSQL
import Fluent

final class User: Content {
    var id: Int?
    let email: String
    let username: String
    let password: String
    let bio: String
    let image: String
    
    init(username: String, password: String, bio: String, image: String) {
        self.username = username
        self.password = password
        self.bio = bio
        self.image = image
    }
}

extension User: Model {
    static var idKey: IDKey {
        return \.id
    }
    
    typealias Database = PostgreSQLDatabase
    typealias ID = Int
}

extension User: Migration {
    
}
