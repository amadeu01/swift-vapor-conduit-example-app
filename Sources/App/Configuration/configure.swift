import Vapor
import FluentPostgreSQL

/// Called before your application initializes.
public func configure(
    _ config: inout Config,
    _ env: inout Environment,
    _ services: inout Services
) throws {
    try services.register(FluentPostgreSQLProvider())
    
    let psqlConfig = PostgreSQLDatabaseConfig(
        hostname: Environment.get("psql_hostname") ?? "localhost",
        username: Environment.get("psql_username") ?? "postgres",
        database: Environment.get("psql_database") ?? nil,
        password: Environment.get("psql_password") ?? nil
    )
    let postgresDatabase = PostgreSQLDatabase(config: psqlConfig)
    
    var databases = DatabasesConfig()
    databases.add(database: postgresDatabase, as: .psql)
    services.register(databases)
    
    var migirateConfig = MigrationConfig()
    migirateConfig.add(model: User.self, database: .psql)
    migirateConfig.add(model: Profile.self, database: .psql)
    migirateConfig.add(model: FollowersAssoc.self, database: .psql)
    services.register(migirateConfig)
}
