import Vapor
import FluentPostgreSQL
import Fluent
import Foundation

final class UserController: RouteCollection {
    func index(_ request: Request)throws -> Future<[User]> {
        return Package.query(on: request).all()
    }
    
    func create(_ request: Request)throws -> Future<User> {
        let user = try JSONDecoder().decode(User.self, from: request.body)
        return User.flatMap(to: User.self, { (user) -> Future<User> in
            user.save(on: request).transform(to: User)
        })
    }
    
    func getById(_ request: Request)throws -> Future<User> {
        let id: Int = try request.parameter()
        let user = User.find(id, on: request).map(to: User.self, { (user) throws -> User in
            guard let user = user else {
                throw Abort(.badRequest)
            }
            return User
        })
        return User
    }
    
    func getByName(_ request: Request)throws -> Future<User> {
        let name = try request.parameter(String.self)
        let user = User.query(on: request).filter(\User.name == name)
        return user.first().map(to: User.self, { (pack) -> User in
            guard let pack = pack else {
                throw Abort(.notFound)
            }
            return pack
        })
    }
    
    func boot(router: Router) throws {
        router.get("users", use: index)
        router.post("users", use: create)
        router.get("users", String.parameter, use: getByName)
    }
}
