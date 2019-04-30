import Vapor
import FluentPostgreSQL
import JWT

final class User: PostgreSQLModel {
    var id: Int?
    let email: String
    let username: String
    var password: String
    let bio: String
    let image: String
    public var createdAt: Date?
    public var updatedAt: Date?
    
    init(id: Int? = nil, username: String, password: String, email: String, bio: String, image: String) {
        self.id = id
        self.username = username
        self.password = password
        self.email = email
        self.bio = bio
        self.image = image
    }
}

extension User: Content {}
extension User: Migration {}
extension User: Parameter {}

// JWT

extension User: JWTPayload {
    func verify(using signer: JWTSigner) throws {}
}

// Public

extension User {
    struct Public: Content {
        let email: String
        let bio: String
        let image: String
    }
    
    func `public`() -> User.Public {
        return User.Public(email: self.email, bio: self.bio, image: self.image)
    }
}

// Register

extension User {
    struct RegisterForm: Content {
        let user: Register
    }
    
    struct Register: Content {
        let username: String
        let email: String
        let password: String
    }
}

// Login

extension User {
    struct LoginForm: Content {
        let user: Login
    }
    
    struct Login: Content {
        let email: String
        let password: String
    }
}

// User (for authentication)

extension User {
    struct AuthUserResponse: Content {
        let user: AuthUser
    }
    
    struct AuthUser: Content {
        let email: String
        let token: String
        let username: String
        let bio: String
        let image: String?
    }
    
    func toAuthUser(token: String) -> AuthUserResponse {
        return AuthUserResponse(
            user: User.AuthUser(
                email: self.email,
                token: token,
                username: self.username,
                bio: self.bio,
                image: self.image
            )
        )
    }
}
