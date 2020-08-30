//
//  EventController.swift
//  
//
//  Created by Максим Сытый on 11.08.2020.
//

import Fluent
import Vapor

struct EventController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let item = routes.grouped("events")
        item.get(use: index)
        item.post(use: create)
        item.group(":eventID") { it in
            it.delete(use: delete)
        }
    }

    func index(req: Request) throws -> EventLoopFuture<[Event]> {
        return Event.query(on: req.db).all()//.with(\.$owner).all()
    }

    func create(req: Request) throws -> EventLoopFuture<Event> {
        let item = try req.content.decode(Event.self)
        return item.save(on: req.db).map { item }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Event.find(req.parameters.get("eventID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
