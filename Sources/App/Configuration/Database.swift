import FluentPostgreSQL
import Vapor

extension DatabaseIdentifier {
    static var postgres: DatabaseIdentifier<PostgreSQLDatabase> {
        return .init("postgresql")
    }
}
