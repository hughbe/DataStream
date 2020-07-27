import XCTest
@testable import DataStream

final class DataStreamTests: XCTestCase {
    func testConstructor() {
        let data = Data([0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07])
        let stream = DataStream(data: data)
        XCTAssertEqual(0, stream.position)
        XCTAssertEqual(8, stream.count)
        XCTAssertEqual(8, stream.remainingCount)
    }
    
    func testReadUInt8() throws {
        let data = Data([0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07])
        var stream = DataStream(data: data)
        XCTAssertEqual(0x00, try stream.readUInt8())
        XCTAssertEqual(1, stream.position)
        XCTAssertEqual(7, stream.remainingCount)
        
        XCTAssertEqual(0x01, try stream.readUInt8())
        XCTAssertEqual(2, stream.position)
        XCTAssertEqual(6, stream.remainingCount)
        
        XCTAssertEqual(0x02, try stream.readUInt8())
        XCTAssertEqual(3, stream.position)
        XCTAssertEqual(5, stream.remainingCount)
        
        XCTAssertEqual(0x03, try stream.readUInt8())
        XCTAssertEqual(4, stream.position)
        XCTAssertEqual(4, stream.remainingCount)
        
        XCTAssertEqual(0x04, try stream.readUInt8())
        XCTAssertEqual(5, stream.position)
        XCTAssertEqual(3, stream.remainingCount)
        
        XCTAssertEqual(0x05, try stream.readUInt8())
        XCTAssertEqual(6, stream.position)
        XCTAssertEqual(2, stream.remainingCount)
        
        XCTAssertEqual(0x06, try stream.readUInt8())
        XCTAssertEqual(7, stream.position)
        XCTAssertEqual(1, stream.remainingCount)
        
        XCTAssertEqual(0x07, try stream.readUInt8())
        XCTAssertEqual(8, stream.position)
        XCTAssertEqual(0, stream.remainingCount)
        
        XCTAssertThrowsError(try stream.readUInt8())
    }
    
    func testReadUInt16() throws {
        let data = Data([0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07])
        var stream = DataStream(data: data)
        XCTAssertEqual(0x0100, try stream.readUInt16())
        XCTAssertEqual(2, stream.position)
        XCTAssertEqual(6, stream.remainingCount)
        
        XCTAssertEqual(0x0302, try stream.readUInt16())
        XCTAssertEqual(4, stream.position)
        XCTAssertEqual(4, stream.remainingCount)
        
        XCTAssertEqual(0x0504, try stream.readUInt16())
        XCTAssertEqual(6, stream.position)
        XCTAssertEqual(2, stream.remainingCount)
        
        XCTAssertEqual(0x0706, try stream.readUInt16())
        XCTAssertEqual(8, stream.position)
        XCTAssertEqual(0, stream.remainingCount)
        
        XCTAssertThrowsError(try stream.readUInt16())
    }
    
    func testReadUInt32() throws {
        let data = Data([0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07])
        var stream = DataStream(data: data)
        XCTAssertEqual(0x03020100, try stream.readUInt32())
        XCTAssertEqual(4, stream.position)
        XCTAssertEqual(4, stream.remainingCount)
        
        XCTAssertEqual(0x07060504, try stream.readUInt32())
        XCTAssertEqual(8, stream.position)
        XCTAssertEqual(0, stream.remainingCount)
        
        XCTAssertThrowsError(try stream.readUInt32())
    }
    
    func testReadUInt64() throws {
        let data = Data([0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07])
        var stream = DataStream(data: data)
        XCTAssertEqual(0x0706050403020100, try stream.readUInt64())
        XCTAssertEqual(8, stream.position)
        XCTAssertEqual(0, stream.remainingCount)
        
        XCTAssertThrowsError(try stream.readUInt64())
    }
    
    func testReadBytes() throws {
        let data = Data([0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07])
        var stream = DataStream(data: data)

        XCTAssertEqual([], try stream.readBytes(count: 0))
        XCTAssertEqual(0, stream.position)
        XCTAssertEqual(8, stream.remainingCount)

        XCTAssertEqual([0x00, 0x01, 0x02], try stream.readBytes(count: 3))
        XCTAssertEqual(3, stream.position)
        XCTAssertEqual(5, stream.remainingCount)
        
        XCTAssertEqual([0x03, 0x04, 0x05], try stream.readBytes(count: 3))
        XCTAssertEqual(6, stream.position)
        XCTAssertEqual(2, stream.remainingCount)
        
        XCTAssertEqual([0x06], try stream.readBytes(count: 1))
        XCTAssertEqual(7, stream.position)
        XCTAssertEqual(1, stream.remainingCount)
        
        XCTAssertEqual([0x07], try stream.readBytes(count: 1))
        XCTAssertEqual(8, stream.position)
        XCTAssertEqual(0, stream.remainingCount)
        
        XCTAssertEqual([], try stream.readBytes(count: 0))
        XCTAssertEqual(8, stream.position)
        XCTAssertEqual(0, stream.remainingCount)
        
        XCTAssertThrowsError(try stream.readBytes(count: 1))
    }
    
    struct MyStruct {
        public var field1: UInt8
        public var field2: UInt8
        public var field3: UInt16
    }
    
    func testRead() throws {
        let data = Data([0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07])
        var stream = DataStream(data: data)

        let s1 = try stream.read(type: MyStruct.self)
        XCTAssertEqual(0x00, s1.field1)
        XCTAssertEqual(0x01, s1.field2)
        XCTAssertEqual(0x0302, s1.field3)
        XCTAssertEqual(4, stream.position)
        XCTAssertEqual(4, stream.remainingCount)

        let s2 = try stream.read(type: MyStruct.self)
        XCTAssertEqual(0x04, s2.field1)
        XCTAssertEqual(0x05, s2.field2)
        XCTAssertEqual(0x0706, s2.field3)
        XCTAssertEqual(8, stream.position)
        XCTAssertEqual(0, stream.remainingCount)
        
        XCTAssertThrowsError(try stream.read(type: MyStruct.self))
    }
    
    func testCopyBytes() throws {
        let data = Data([0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07])
        var stream = DataStream(data: data)

        var buffer = [UInt8](repeating: 0xFF, count: 10)
        try buffer.withUnsafeMutableBufferPointer {
            try stream.copyBytes(to: $0, count: 0)
        }
        XCTAssertEqual([0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF], buffer)

        try buffer.withUnsafeMutableBufferPointer {
            try stream.copyBytes(to: $0, count: 3)
        }
        XCTAssertEqual([0x00, 0x01, 0x02, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF], buffer)
        
        try buffer.withUnsafeMutableBufferPointer {
            try stream.copyBytes(to: $0, count: 3)
        }
        XCTAssertEqual([0x03, 0x04, 0x05, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF], buffer)
        
        try buffer.withUnsafeMutableBufferPointer {
            try stream.copyBytes(to: $0, count: 1)
        }
        XCTAssertEqual([0x06, 0x04, 0x05, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF], buffer)
        
        try buffer.withUnsafeMutableBufferPointer {
            try stream.copyBytes(to: $0, count: 1)
        }
        XCTAssertEqual([0x07, 0x04, 0x05, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF], buffer)
        
        try buffer.withUnsafeMutableBufferPointer {
            try stream.copyBytes(to: $0, count: 0)
        }
        XCTAssertEqual([0x07, 0x04, 0x05, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF], buffer)

        XCTAssertThrowsError(try buffer.withUnsafeMutableBufferPointer {
            try stream.copyBytes(to: $0, count: 1)
        })
    }
    
    func testPosition() throws {
        let data = Data([0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07])
        var stream = DataStream(data: data)
        
        // Set middle.
        stream.position = 1
        XCTAssertEqual(1, stream.position)
        XCTAssertEqual(7, stream.remainingCount)
        XCTAssertEqual(0x01, try stream.readUInt8())
        
        // Set first.
        stream.position = 0
        XCTAssertEqual(0, stream.position)
        XCTAssertEqual(8, stream.remainingCount)
        XCTAssertEqual(0x00, try stream.readUInt8())

        // Set last.
        stream.position = 7
        XCTAssertEqual(7, stream.position)
        XCTAssertEqual(1, stream.remainingCount)
        XCTAssertEqual(0x07, try stream.readUInt8())
    }

    static var allTests = [
        ("testConstructor", testConstructor),
        ("testReadUInt8", testReadUInt8),
        ("testReadUInt16", testReadUInt16),
        ("testReadUInt32", testReadUInt32),
        ("testReadUInt64", testReadUInt64),
        ("testReadBytes", testReadBytes),
        ("testRead", testRead),
        ("testCopyBytes", testCopyBytes),
        ("textPosition", testPosition),
    ]
}
