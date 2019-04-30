import Vapor
import FluentPostgreSQL
import Fluent
import Crypto
import JWT

final class UserController: RouteCollection {
    func index(_ request: Request) throws -> Future<[User.Public]> {
        return User.query(on: request).all().map { userList in
            userList.map { $0.public() }
        }
    }
    
    func create(_ request: Request) throws -> Future<User.Public> {
        return try request.content.decode(User.RegisterForm.self).flatMap { userForm in
            let user = User(
                id: nil,
                username: userForm.user.username,
                password: try BCrypt.hash(userForm.user.password),
                email: userForm.user.email,
                bio: "",
                image: ""
            )
            
            return user.save(on: request).map { $0.public() }
        }
    }
    
    func getById(_ request: Request) throws -> Future<User.Public> {
        return try request.parameters.next(User.self).map { $0.public() }
    }
    
    func login(_ request: Request) throws -> Future<String> {
        return try request.content.decode(User.LoginForm.self).flatMap { userForm in
            User
                .query(on: request)
                .filter(\User.email, .equal, userForm.user.email)
                .first()
                .map { user -> User in
                
                    guard
                        let user = user,
                        try BCrypt.verify(userForm.user.password, created: user.password )
                    else {
                        throw Abort(.unauthorized)
                    }
                    
                    return user
            }.map { user in
                let data = try JWT<User>(payload: user).sign(using: .hs256(key: "secret"))
                return String(data: data, encoding: .utf8) ?? ""
            }
        }
    }
    
    func getCurrentUser(_ request: Request) throws -> Future<User.AuthUserResponse> {
        guard let bearer = request.http.headers.bearerAuthorization else {
            throw Abort(.unauthorized)
        }
        
        let jwt = try JWT<User>(from: bearer.token, verifiedUsing: .hs256(key: "secret"))
        return User.query(on: request).filter(\User.email, .equal, jwt.payload.email).first().map { user in
            guard let user = user else {
                throw Abort(.internalServerError)
            }
            
            return user.toAuthUser(token: bearer.token)
        }
    }
    
    func boot(router: Router) throws {
        router.get("users", use: index)
        router.post("users", use: create)
        router.get("users", User.parameter, use: getById)
        router.post("users/login", use: login)
        router.get("user", use: getCurrentUser)
    }
}
