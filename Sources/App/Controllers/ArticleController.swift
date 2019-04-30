import Vapor
import FluentPostgreSQL
import Foundation

final class ArticleController: RouteCollection {
    func index(_ request: Request)throws -> Future<[Article]> {
        return Article.query(on: request).all()
    }
    
    func create(_ request: Request)throws -> Future<Article> {
        return try request.content.decode(Article.self).flatMap { article in
            article.save(on: request)
        }
    }
    
    func getById(_ request: Request)throws -> Future<Article> {
        return try request.parameters.next(Article.self)
    }
    
    func boot(router: Router) throws {
        router.get("articles", use: index)
        router.post("articles", use: create)
        router.get("articles", Article.parameter, use: getById)
    }
}
