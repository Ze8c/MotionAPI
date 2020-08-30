//
//  MigrationModels.swift
//  
//
//  Created by Максим Сытый on 11.08.2020.
//

import Fluent

struct MigrationModels: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(User.schema)
                .id()
                .field("name", .string, .required)
                .field("avatar", .string)
                .field("contacts", .string)
                .field("info", .string)
                .field("created_at", .datetime, .required)
                .create(),
            database.schema(Event.schema)
                .id()
                //.field("owner_id", .uuid, .required)
                //.field("owner_id", .uuid, .required, .references("users", "id"))
                .field("owner_id", .uuid, .required)
                .foreignKey("owner_id", references: User.schema, .id)
                .field("title", .string, .required)
                .field("lat", .double, .required)
                .field("lon", .double, .required)
                .field("date", .string)
                .field("info", .string, .required)
                .field("media", .array(of: .string))
                .field("ended", .bool, .required)
                .create(),
        ])
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(User.schema).delete(),
            database.schema(Event.schema).delete(),
        ])
    }
}
