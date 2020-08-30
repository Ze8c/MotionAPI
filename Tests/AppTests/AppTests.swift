@testable import App
import XCTVapor

final class AppTests: XCTestCase {
    
    func testHiPeople() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try configure(app)

        try app.test(.GET, "hi") { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "Hi, people!")
        }
    }
    
    func testGetUsers() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try configure(app)

        try app.test(.GET, "users") { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertNotEqual(res.body.string, "")
        }
    }
}
