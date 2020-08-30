//
//  UserController.swift
//  
//
//  Created by Максим Сытый on 11.08.2020.
//

import Fluent
import Vapor

struct UserController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let item = routes.grouped("users")
        item.get(use: index)
        item.post(use: create)
        item.group(":userID") { it in
            it.delete(use: delete)
        }
    }

    func index(req: Request) throws -> EventLoopFuture<[User]> {
        return User.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<User> {
        let item = try req.content.decode(User.self)
        return item.save(on: req.db).map { item }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return User.find(req.parameters.get("userID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
