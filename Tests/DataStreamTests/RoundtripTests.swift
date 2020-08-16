import XCTest
@testable import DataStream

final class RoundtripTests: XCTestCase {
    func testRoundtripInt32() throws {
        do {
            var outputStream = OutputDataStream()
            outputStream.write(1234 as UInt32, endianess: .bigEndian)
            var stream = DataStream(data: outputStream.data)
            XCTAssertEqual(1234, try stream.read(endianess: .bigEndian) as UInt32)
        }
    }
}
