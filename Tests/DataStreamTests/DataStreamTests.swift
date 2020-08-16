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
        XCTAssertEqual(0x00, try stream.read() as UInt8)
        XCTAssertEqual(1, stream.position)
        XCTAssertEqual(7, stream.remainingCount)
        
        XCTAssertEqual(0x01, try stream.read() as UInt8)
        XCTAssertEqual(2, stream.position)
        XCTAssertEqual(6, stream.remainingCount)
        
        XCTAssertEqual(0x02, try stream.read() as UInt8)
        XCTAssertEqual(3, stream.position)
        XCTAssertEqual(5, stream.remainingCount)
        
        XCTAssertEqual(0x03, try stream.read() as UInt8)
        XCTAssertEqual(4, stream.position)
        XCTAssertEqual(4, stream.remainingCount)
        
        XCTAssertEqual(0x04, try stream.read() as UInt8)
        XCTAssertEqual(5, stream.position)
        XCTAssertEqual(3, stream.remainingCount)
        
        XCTAssertEqual(0x05, try stream.read() as UInt8)
        XCTAssertEqual(6, stream.position)
        XCTAssertEqual(2, stream.remainingCount)
        
        XCTAssertEqual(0x06, try stream.read() as UInt8)
        XCTAssertEqual(7, stream.position)
        XCTAssertEqual(1, stream.remainingCount)
        
        XCTAssertEqual(0x07, try stream.read() as UInt8)
        XCTAssertEqual(8, stream.position)
        XCTAssertEqual(0, stream.remainingCount)
        
        XCTAssertThrowsError(try stream.read() as UInt8)
    }
    
    func testReadInt8() throws {
        let data = Data([0x00, 0x81, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07])
        var stream = DataStream(data: data)
        XCTAssertEqual(0x00, try stream.read() as Int8)
        XCTAssertEqual(1, stream.position)
        XCTAssertEqual(7, stream.remainingCount)
        
        XCTAssertEqual(-127, try stream.read() as Int8)
        XCTAssertEqual(2, stream.position)
        XCTAssertEqual(6, stream.remainingCount)
        
        XCTAssertEqual(0x02, try stream.read() as Int8)
        XCTAssertEqual(3, stream.position)
        XCTAssertEqual(5, stream.remainingCount)
        
        XCTAssertEqual(0x03, try stream.read() as Int8)
        XCTAssertEqual(4, stream.position)
        XCTAssertEqual(4, stream.remainingCount)
        
        XCTAssertEqual(0x04, try stream.read() as Int8)
        XCTAssertEqual(5, stream.position)
        XCTAssertEqual(3, stream.remainingCount)
        
        XCTAssertEqual(0x05, try stream.read() as Int8)
        XCTAssertEqual(6, stream.position)
        XCTAssertEqual(2, stream.remainingCount)
        
        XCTAssertEqual(0x06, try stream.read() as Int8)
        XCTAssertEqual(7, stream.position)
        XCTAssertEqual(1, stream.remainingCount)
        
        XCTAssertEqual(0x07, try stream.read() as Int8)
        XCTAssertEqual(8, stream.position)
        XCTAssertEqual(0, stream.remainingCount)
        
        XCTAssertThrowsError(try stream.read() as Int8)
    }
    
    func testReadUInt16() throws {
        do {
            let data = Data([0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07])
            var stream = DataStream(data: data)
            XCTAssertEqual(0x0100, try stream.read() as UInt16)
            XCTAssertEqual(2, stream.position)
            XCTAssertEqual(6, stream.remainingCount)
            
            XCTAssertEqual(0x0302, try stream.read() as UInt16)
            XCTAssertEqual(4, stream.position)
            XCTAssertEqual(4, stream.remainingCount)
            
            XCTAssertEqual(0x0504, try stream.read() as UInt16)
            XCTAssertEqual(6, stream.position)
            XCTAssertEqual(2, stream.remainingCount)
            
            XCTAssertEqual(0x0706, try stream.read() as UInt16)
            XCTAssertEqual(8, stream.position)
            XCTAssertEqual(0, stream.remainingCount)
            
            XCTAssertThrowsError(try stream.read() as UInt16)
        }
        do {
            let data = Data([0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07])
            var stream = DataStream(data: data)
            XCTAssertEqual(0x0001, try stream.read(endianess: .bigEndian) as UInt16)
            XCTAssertEqual(2, stream.position)
            XCTAssertEqual(6, stream.remainingCount)
            
            XCTAssertEqual(0x0203, try stream.read(endianess: .bigEndian) as UInt16)
            XCTAssertEqual(4, stream.position)
            XCTAssertEqual(4, stream.remainingCount)
            
            XCTAssertEqual(0x0405, try stream.read(endianess: .bigEndian) as UInt16)
            XCTAssertEqual(6, stream.position)
            XCTAssertEqual(2, stream.remainingCount)
            
            XCTAssertEqual(0x0607, try stream.read(endianess: .bigEndian) as UInt16)
            XCTAssertEqual(8, stream.position)
            XCTAssertEqual(0, stream.remainingCount)
            
            XCTAssertThrowsError(try stream.read(endianess: .bigEndian) as UInt16)
        }
        do {
            let data = Data([0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07])
            var stream = DataStream(data: data)
            XCTAssertEqual(0x0100, try stream.read(endianess: .littleEndian) as UInt16)
            XCTAssertEqual(2, stream.position)
            XCTAssertEqual(6, stream.remainingCount)
            
            XCTAssertEqual(0x0302, try stream.read(endianess: .littleEndian) as UInt16)
            XCTAssertEqual(4, stream.position)
            XCTAssertEqual(4, stream.remainingCount)
            
            XCTAssertEqual(0x0504, try stream.read(endianess: .littleEndian) as UInt16)
            XCTAssertEqual(6, stream.position)
            XCTAssertEqual(2, stream.remainingCount)
            
            XCTAssertEqual(0x0706, try stream.read(endianess: .littleEndian) as UInt16)
            XCTAssertEqual(8, stream.position)
            XCTAssertEqual(0, stream.remainingCount)
            
            XCTAssertThrowsError(try stream.read(endianess: .littleEndian) as UInt16)
        }
    }
    
    func testReadInt16() throws {
        do {
            let data = Data([0x00, 0x01, 0x02, 0x83, 0x04, 0x05, 0x06, 0x07])
            var stream = DataStream(data: data)
            XCTAssertEqual(0x0100, try stream.read() as Int16)
            XCTAssertEqual(2, stream.position)
            XCTAssertEqual(6, stream.remainingCount)
            
            XCTAssertEqual(-31998, try stream.read() as Int16)
            XCTAssertEqual(4, stream.position)
            XCTAssertEqual(4, stream.remainingCount)
            
            XCTAssertEqual(0x0504, try stream.read() as Int16)
            XCTAssertEqual(6, stream.position)
            XCTAssertEqual(2, stream.remainingCount)
            
            XCTAssertEqual(0x0706, try stream.read() as Int16)
            XCTAssertEqual(8, stream.position)
            XCTAssertEqual(0, stream.remainingCount)
            
            XCTAssertThrowsError(try stream.read() as Int16)
        }
        do {
            let data = Data([0x00, 0x01, 0x02, 0x83, 0x04, 0x05, 0x06, 0x07])
            var stream = DataStream(data: data)
            XCTAssertEqual(0x0001, try stream.read(endianess: .bigEndian) as Int16)
            XCTAssertEqual(2, stream.position)
            XCTAssertEqual(6, stream.remainingCount)
            
            XCTAssertEqual(0x0283, try stream.read(endianess: .bigEndian) as Int16)
            XCTAssertEqual(4, stream.position)
            XCTAssertEqual(4, stream.remainingCount)
            
            XCTAssertEqual(0x0405, try stream.read(endianess: .bigEndian) as Int16)
            XCTAssertEqual(6, stream.position)
            XCTAssertEqual(2, stream.remainingCount)
            
            XCTAssertEqual(0x0607, try stream.read(endianess: .bigEndian) as Int16)
            XCTAssertEqual(8, stream.position)
            XCTAssertEqual(0, stream.remainingCount)
            
            XCTAssertThrowsError(try stream.read(endianess: .bigEndian) as Int16)
        }
        do {
            let data = Data([0x00, 0x01, 0x02, 0x83, 0x04, 0x05, 0x06, 0x07])
            var stream = DataStream(data: data)
            XCTAssertEqual(0x0100, try stream.read(endianess: .littleEndian) as Int16)
            XCTAssertEqual(2, stream.position)
            XCTAssertEqual(6, stream.remainingCount)
            
            XCTAssertEqual(-31998, try stream.read(endianess: .littleEndian) as Int16)
            XCTAssertEqual(4, stream.position)
            XCTAssertEqual(4, stream.remainingCount)
            
            XCTAssertEqual(0x0504, try stream.read(endianess: .littleEndian) as Int16)
            XCTAssertEqual(6, stream.position)
            XCTAssertEqual(2, stream.remainingCount)
            
            XCTAssertEqual(0x0706, try stream.read(endianess: .littleEndian) as Int16)
            XCTAssertEqual(8, stream.position)
            XCTAssertEqual(0, stream.remainingCount)
            
            XCTAssertThrowsError(try stream.read(endianess: .littleEndian) as Int16)
        }
    }
    
    func testReadUInt32() throws {
        do {
            let data = Data([0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07])
            var stream = DataStream(data: data)
            XCTAssertEqual(0x03020100, try stream.read() as UInt32)
            XCTAssertEqual(4, stream.position)
            XCTAssertEqual(4, stream.remainingCount)
            
            XCTAssertEqual(0x07060504, try stream.read() as UInt32)
            XCTAssertEqual(8, stream.position)
            XCTAssertEqual(0, stream.remainingCount)
            
            XCTAssertThrowsError(try stream.read() as UInt32)
        }
        do {
            let data = Data([0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07])
            var stream = DataStream(data: data)
            XCTAssertEqual(0x00010203, try stream.read(endianess: .bigEndian) as UInt32)
            XCTAssertEqual(4, stream.position)
            XCTAssertEqual(4, stream.remainingCount)
            
            XCTAssertEqual(0x04050607, try stream.read(endianess: .bigEndian) as UInt32)
            XCTAssertEqual(8, stream.position)
            XCTAssertEqual(0, stream.remainingCount)
            
            XCTAssertThrowsError(try stream.read(endianess: .bigEndian) as UInt32)
        }
        do {
            let data = Data([0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07])
            var stream = DataStream(data: data)
            XCTAssertEqual(0x03020100, try stream.read(endianess: .littleEndian) as UInt32)
            XCTAssertEqual(4, stream.position)
            XCTAssertEqual(4, stream.remainingCount)
            
            XCTAssertEqual(0x07060504, try stream.read(endianess: .littleEndian) as UInt32)
            XCTAssertEqual(8, stream.position)
            XCTAssertEqual(0, stream.remainingCount)
            
            XCTAssertThrowsError(try stream.read(endianess: .littleEndian) as UInt32)
        }
    }
    
    func testReadInt32() throws {
        do {
            let data = Data([0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x87])
            var stream = DataStream(data: data)
            XCTAssertEqual(0x03020100, try stream.read() as Int32)
            XCTAssertEqual(4, stream.position)
            XCTAssertEqual(4, stream.remainingCount)
            
            XCTAssertEqual(-2029648636, try stream.read() as Int32)
            XCTAssertEqual(8, stream.position)
            XCTAssertEqual(0, stream.remainingCount)
            
            XCTAssertThrowsError(try stream.read() as Int32)
        }
        do {
            let data = Data([0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x87])
            var stream = DataStream(data: data)
            XCTAssertEqual(0x000010203, try stream.read(endianess: .bigEndian) as Int32)
            XCTAssertEqual(4, stream.position)
            XCTAssertEqual(4, stream.remainingCount)
            
            XCTAssertEqual(0x0004050687, try stream.read(endianess: .bigEndian) as Int32)
            XCTAssertEqual(8, stream.position)
            XCTAssertEqual(0, stream.remainingCount)
            
            XCTAssertThrowsError(try stream.read(endianess: .bigEndian) as Int32)
        }
        do {
            let data = Data([0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x87])
            var stream = DataStream(data: data)
            XCTAssertEqual(0x03020100, try stream.read(endianess: .littleEndian) as Int32)
            XCTAssertEqual(4, stream.position)
            XCTAssertEqual(4, stream.remainingCount)
            
            XCTAssertEqual(-2029648636, try stream.read(endianess: .littleEndian) as Int32)
            XCTAssertEqual(8, stream.position)
            XCTAssertEqual(0, stream.remainingCount)
            
            XCTAssertThrowsError(try stream.read(endianess: .littleEndian) as Int32)
        }
    }
    
    func testReadUInt64() throws {
        do {
            let data = Data([0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07])
            var stream = DataStream(data: data)
            XCTAssertEqual(0x0706050403020100, try stream.read() as UInt64)
            XCTAssertEqual(8, stream.position)
            XCTAssertEqual(0, stream.remainingCount)
            
            XCTAssertThrowsError(try stream.read() as UInt64)
        }
        do {
            let data = Data([0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07])
            var stream = DataStream(data: data)
            XCTAssertEqual(0x1020304050607, try stream.read(endianess: .bigEndian) as UInt64)
            XCTAssertEqual(8, stream.position)
            XCTAssertEqual(0, stream.remainingCount)
            
            XCTAssertThrowsError(try stream.read(endianess: .bigEndian) as UInt64)
        }
        do {
            let data = Data([0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07])
            var stream = DataStream(data: data)
            XCTAssertEqual(0x0706050403020100, try stream.read(endianess: .littleEndian) as UInt64)
            XCTAssertEqual(8, stream.position)
            XCTAssertEqual(0, stream.remainingCount)
            
            XCTAssertThrowsError(try stream.read(endianess: .littleEndian) as UInt64)
        }
    }
    
    func testReadInt64() throws {
        do {
            let data = Data([0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x80])
            var stream = DataStream(data: data)
            XCTAssertEqual(0x0706050403020100, try stream.read() as Int64)
            XCTAssertEqual(8, stream.position)
            XCTAssertEqual(8, stream.remainingCount)
            XCTAssertEqual(-9221677672206040832, try stream.read() as Int64)
            XCTAssertEqual(16, stream.position)
            XCTAssertEqual(0, stream.remainingCount)
            
            XCTAssertThrowsError(try stream.read() as Int64)
        }
        do {
            let data = Data([0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x80])
            var stream = DataStream(data: data)
            XCTAssertEqual(0x01020304050607, try stream.read(endianess: .bigEndian) as Int64)
            XCTAssertEqual(8, stream.position)
            XCTAssertEqual(8, stream.remainingCount)
            XCTAssertEqual(0x01020304050680, try stream.read(endianess: .bigEndian) as Int64)
            XCTAssertEqual(16, stream.position)
            XCTAssertEqual(0, stream.remainingCount)
            
            XCTAssertThrowsError(try stream.read() as Int64)
        }
        do {
            let data = Data([0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x80])
            var stream = DataStream(data: data)
            XCTAssertEqual(0x0706050403020100, try stream.read(endianess: .littleEndian) as Int64)
            XCTAssertEqual(8, stream.position)
            XCTAssertEqual(8, stream.remainingCount)
            XCTAssertEqual(-9221677672206040832, try stream.read(endianess: .littleEndian) as Int64)
            XCTAssertEqual(16, stream.position)
            XCTAssertEqual(0, stream.remainingCount)
            
            XCTAssertThrowsError(try stream.read() as Int64)
        }
    }
    
    func testReadFloat() throws {
        do {
            let data = Data([0x00, 0x01, 0x02, 0x03])
            var stream = DataStream(data: data)
            XCTAssertEqual(3.8204714e-37, try stream.readFloat() as Float)
            XCTAssertEqual(4, stream.position)
            XCTAssertEqual(0, stream.remainingCount)
            
            XCTAssertThrowsError(try stream.readFloat(endianess: .bigEndian) as Float)
        }
        do {
            let data = Data([0x00, 0x01, 0x02, 0x03])
            var stream = DataStream(data: data)
            XCTAssertEqual(Float(bitPattern: 0x00010203), try stream.readFloat(endianess: .bigEndian) as Float)
            XCTAssertEqual(4, stream.position)
            XCTAssertEqual(0, stream.remainingCount)
            
            XCTAssertThrowsError(try stream.readFloat(endianess: .bigEndian) as Float)
        }
        do {
            let data = Data([0x00, 0x01, 0x02, 0x03])
            var stream = DataStream(data: data)
            XCTAssertEqual(3.8204714e-37, try stream.readFloat(endianess: .littleEndian) as Float)
            XCTAssertEqual(4, stream.position)
            XCTAssertEqual(0, stream.remainingCount)
            
            XCTAssertThrowsError(try stream.readFloat(endianess: .littleEndian) as Float)
        }
    }
    
    func testReadDouble() throws {
        do {
            let data = Data([0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07])
            var stream = DataStream(data: data)
            XCTAssertEqual(7.949928895127363e-275, try stream.readDouble() as Double)
            XCTAssertEqual(8, stream.position)
            XCTAssertEqual(0, stream.remainingCount)
            
            XCTAssertThrowsError(try stream.readDouble() as Double)
        }
        do {
            let data = Data([0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07])
            var stream = DataStream(data: data)
            XCTAssertEqual(Double(bitPattern: 0x01020304050607) as Double, try stream.readDouble(endianess: .bigEndian) as Double)
            XCTAssertEqual(8, stream.position)
            XCTAssertEqual(0, stream.remainingCount)
            
            XCTAssertThrowsError(try stream.readDouble(endianess: .bigEndian) as Double)
        }
        do {
            let data = Data([0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07])
            var stream = DataStream(data: data)
            XCTAssertEqual(7.949928895127363e-275, try stream.readDouble())
            XCTAssertEqual(8, stream.position)
            XCTAssertEqual(0, stream.remainingCount)
            
            XCTAssertThrowsError(try stream.readDouble(endianess: .littleEndian) as Double)
        }
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
    
    func testReadString() throws {
        let data = Data([0x41, 0x42, 0x43, 0x41, 0x00, 0x42, 0x00, 0x43, 0x00])
        var stream = DataStream(data: data)
        XCTAssertEqual("A", try stream.readString(count: 1, encoding: .ascii))
        XCTAssertEqual(1, stream.position)
        XCTAssertEqual(8, stream.remainingCount)
        
        XCTAssertEqual("BC", try stream.readString(count: 2, encoding: .ascii))
        XCTAssertEqual(3, stream.position)
        XCTAssertEqual(6, stream.remainingCount)
        
        XCTAssertEqual("ABC", try stream.readString(count: 6, encoding: .utf16LittleEndian))
        XCTAssertEqual(9, stream.position)
        XCTAssertEqual(0, stream.remainingCount)
        
        XCTAssertThrowsError(try stream.readString(count: 1, encoding: .ascii))
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
        XCTAssertEqual(0x01, try stream.read() as UInt8)
        
        // Set first.
        stream.position = 0
        XCTAssertEqual(0, stream.position)
        XCTAssertEqual(8, stream.remainingCount)
        XCTAssertEqual(0x00, try stream.read() as UInt8)

        // Set last.
        stream.position = 7
        XCTAssertEqual(7, stream.position)
        XCTAssertEqual(1, stream.remainingCount)
        XCTAssertEqual(0x07, try stream.read() as UInt8)
    }

    static var allTests = [
        ("testConstructor", testConstructor),
        ("testReadUInt8", testReadUInt8),
        ("testReadInt8", testReadInt8),
        ("testReadUInt16", testReadUInt16),
        ("testReadInt16", testReadInt16),
        ("testReadUInt32", testReadUInt32),
        ("testReadInt32", testReadInt32),
        ("testReadUInt64", testReadUInt64),
        ("testReadInt64", testReadInt64),
        ("testReadFloat", testReadFloat),
        ("testReadDouble", testReadDouble),
        ("testReadString", testReadString),
        ("testReadBytes", testReadBytes),
        ("testRead", testRead),
        ("testCopyBytes", testCopyBytes),
        ("textPosition", testPosition),
    ]
}
