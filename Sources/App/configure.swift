import Vapor
import FluentPostgreSQL

/// Called before your application initializes.
public func configure(
    _ config: inout Config,
    _ env: inout Environment,
    _ services: inout Services
) throws {
    try services.register(FluentProvider())
    try services.register(FluentPostgreSQLProvider())
    
    let psqlConfig = PostgreSQLDatabaseConfig(hostname: "localhost", port: 5432, username: "calebkleveter")
    var dbConfig = DatabaseConfig()
    
    let database = PostgreSQLDatabase(config: psqlConfig)
    dbConfig.add(database: database, as: .postgres)
    services.register(dbConfig)
    
    var migirateConfig = MigrationConfig()
    migirateConfig.add(model: Package.self, database: .postgres)
    services.register(migirateConfig)
}
