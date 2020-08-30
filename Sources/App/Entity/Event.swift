//
//  Event.swift
//  
//
//  Created by Максим Сытый on 11.08.2020.
//

import Fluent
import Vapor

final class Event: Model, Content, Hashable {
    
    static let schema: String = "events"
    
    @ID(key: .id) var id: UUID?
    
    //@Parent(key: "owner_id") var owner: User
    @Field(key: "owner_id") var ownerID: UUID
    @Field(key: "title") var title: String
    @Field(key: "lat") var lat: Double
    @Field(key: "lon") var lon: Double
    @Field(key: "date") var date: String?
    @Field(key: "info") var info: String
    @OptionalField(key: "media") var media: [String]?
    @Field(key: "ended") var ended: Bool

    init() { }

    init(id: UUID? = nil,
         ownerID: UUID,
         //ownerID: User.IDValue,
         title: String,
         lat: Double,
         lon: Double,
         date: String?,
         info: String,
         media: [String]? = nil,
         ended: Bool) {
        
        self.id = id
        self.ownerID = ownerID
        //self.$owner.id = ownerID
        self.title = title
        self.lat = lat
        self.lon = lon
        self.date = date
        self.info = info
        self.media = media
        self.ended = ended
    }
    
    static func == (lhs: Event, rhs: Event) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
