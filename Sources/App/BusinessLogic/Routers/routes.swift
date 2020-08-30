import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    app.get { req -> User in
        User(id: UUID(),
             name: "Hrum",
             avatar: "Some avatar",
             contacts: "TG: booooomz",
             info: "I'm true",
             createdAt: Date())
    }
    
    app.on(.GET, "hi") { req in
        return "Hi, people!"
    }
    
    app.get("sign-in") { req -> Response in
        let body = """
        <form action="/sign-in" method="post">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" value="">
            
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" value="">
            
            <input type="submit" value="Submit">
        </form>
        """
        
        return .init(status: .ok,
                     version: req.version,
                     headers: HTTPHeaders.init([("Content-Type", "text/html; charset=UTF-8")]),
                     body: .init(string: body))
    }
    
    try app.register(collection: UserController())
    try app.register(collection: EventController())
}
