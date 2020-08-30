import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    //MARK: -Server
    app.http.server.configuration.hostname = "192.168.1.65"
    app.http.server.configuration.port = 8080
    
    //MARK: -File service. Serves files from `Public/` directory
    // ├── Public
    // ├── Sources
    // │   ├── App
    // │   │   └── (Source code)
    // │   └── Run
    // │       └── main.swift
    // ├── Tests
    // │   └── AppTests
    // └── Package.swift
    
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    //MARK: -DB
    app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? "host",
        username: Environment.get("DATABASE_USERNAME") ?? "username",
        password: Environment.get("DATABASE_PASSWORD") ?? "password",
        database: Environment.get("DATABASE_NAME") ?? "db_name"
    ), as: .psql)
    
    app.migrations.add(MigrationModels())

    //MARK: -Register routes
    try routes(app)
}
