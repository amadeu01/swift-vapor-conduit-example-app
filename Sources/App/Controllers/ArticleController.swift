import Vapor
import FluentPostgreSQL
import Fluent
import Foundation

final class ArticleController: RouteCollection {
    func index(_ request: Request)throws -> Future<[Article]> {
        return Article.query(on: request).all()
    }
    
    func create(_ request: Request)throws -> Future<Article> {
        let article = try JSONDecoder().decode(Article.self, from: request.body)
        return article.flatMap(to: Article.self, { (article) -> Future<Article> in
            article.save(on: request).transform(to: article)
        })
    }
    
    func getById(_ request: Request)throws -> Future<Article> {
        let id: Int = try request.parameter()
        let article = Article.find(id, on: request).map(to: Article.self, { (article)throws -> Article in
            guard let article = article else {
                throw Abort(.badRequest)
            }
            return article
        })
        return article
    }
    
    func boot(router: Router) throws {
        router.get("articles", use: index)
        router.post("articles", use: create)
    }
}
