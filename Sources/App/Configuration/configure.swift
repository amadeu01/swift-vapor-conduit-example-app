import Vapor
import FluentPostgreSQL

/// Called before your application initializes.
public func configure(
    _ config: inout Config,
    _ env: inout Environment,
    _ services: inout Services
) throws {
    let router = EngineRouter.default()
    try routes(router)
    
    try services.register(FluentProvider())
    try services.register(FluentPostgreSQLProvider())
    
    let psqlConfig = PostgreSQLDatabaseConfig(hostname: "localhost", port: 5432, username: "postgres")
    var dbConfig = DatabaseConfig()
    
    let database = PostgreSQLDatabase(config: psqlConfig)
    dbConfig.add(database: database, as: .postgres)
    services.register(dbConfig)
    
    var migirateConfig = MigrationConfig()
//    migirateConfig.add(model: User.self, database: .postgres)
//    migirateConfig.add(model: Profile.self, database: .postgres)
//    migirateConfig.add(model: FollowersAssoc.self, database: .postgres)
    services.register(router, as: Router.self)
    services.register(migirateConfig)
}
