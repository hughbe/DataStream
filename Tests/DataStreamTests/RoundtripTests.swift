import XCTest
@testable import DataStream

final class RoundtripTests: XCTestCase {
    func testRoundtripInt16() throws {
        do {
            var outputStream = OutputDataStream()
            outputStream.write(1234 as UInt16, endianess: .bigEndian)
            var stream = DataStream(data: outputStream.data)
            XCTAssertEqual(1234, try stream.read(endianess: .bigEndian) as UInt16)
        }
    }

    func testRoundtripInt32() throws {
        do {
            var outputStream = OutputDataStream()
            outputStream.write(1234 as UInt32, endianess: .bigEndian)
            var stream = DataStream(data: outputStream.data)
            XCTAssertEqual(1234, try stream.read(endianess: .bigEndian) as UInt32)
        }
    }
    
    static var allTests = [
        ("testRoundtripInt16", testRoundtripInt16),
        ("testRoundtripInt32", testRoundtripInt32),
    ]
}
