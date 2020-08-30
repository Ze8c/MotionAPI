//
//  User.swift
//  
//
//  Created by Максим Сытый on 11.08.2020.
//

import Fluent
import Vapor

final class User: Model, Content, Hashable {
    
    static let schema: String = "users"
    
    @ID(key: .id) var id: UUID?

    @Field(key: "name") var name: String
    @OptionalField(key: "avatar") var avatar: String?
    @OptionalField(key: "contacts") var contacts: String?
    @OptionalField(key: "info") var info: String?
    @Timestamp(key: "created_at", on: .create) var createdAt: Date?
    //@Children(for: \.$owner) var events: [Event]

    init() { }

    init(id: UUID? = nil,
         name: String,
         avatar: String? = nil,
         contacts: String? = nil,
         info: String? = nil,
         createdAt: Date?) {
        
        self.id = id
        self.name = name
        self.avatar = avatar
        self.contacts = contacts
        self.info = info
        self.createdAt = createdAt
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
