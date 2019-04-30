import Routing
import Vapor

final class Routes: RouteCollection {
    let app: Application
    
    init(app: Application) {
        self.app = app
    }
    
    func boot(router: Router) throws {
        let api = router.grouped("api")
        try api.register(collection: UserController())
        try api.register(collection: ArticleController())
    }
}
