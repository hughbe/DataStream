import XCTest
@testable import DataStream

func XCTAssertEqualHex(_ expression1: [UInt8], _ expression2: [UInt8], file: StaticString = #file, line: UInt = #line) {
    func hexString(_ array: [UInt8]) -> String {
        var result = "["
        for (index, value) in array.enumerated() {
            result += value.hexString
            if index != array.count - 1 {
                result += ", "
            }
        }
        result += "]"
        return result
    }
    XCTAssertEqual(hexString(expression1), hexString(expression2), file: file, line: line)
}

final class OutputDataStreamTests: XCTestCase {
    func testWriteUInt8() {
        do {
            var stream = OutputDataStream()
            stream.write(123 as UInt8, endianess: .systemDefault)
            XCTAssertEqualHex([0x7B], [UInt8](stream.data))
        }
        do {
            var stream = OutputDataStream()
            stream.write(123 as UInt8, endianess: .bigEndian)
            XCTAssertEqualHex([0x7B], [UInt8](stream.data))
        }
        do {
            var stream = OutputDataStream()
            stream.write(123 as UInt8, endianess: .littleEndian)
            XCTAssertEqualHex([0x7B], [UInt8](stream.data))
        }
    }

    func testWriteInt8() {
        do {
            var stream = OutputDataStream()
            stream.write(123 as Int8, endianess: .systemDefault)
            XCTAssertEqualHex([0x7B], [UInt8](stream.data))
        }
        do {
            var stream = OutputDataStream()
            stream.write(123 as Int8, endianess: .bigEndian)
            XCTAssertEqualHex([0x7B], [UInt8](stream.data))
        }
        do {
            var stream = OutputDataStream()
            stream.write(123 as Int8, endianess: .littleEndian)
            XCTAssertEqualHex([0x7B], [UInt8](stream.data))
        }
    }

    func testWriteUInt16() {
        do {
            var stream = OutputDataStream()
            stream.write(1234 as UInt16, endianess: .systemDefault)
            XCTAssertEqualHex([0xD2, 0x04], [UInt8](stream.data))
        }
        do {
            var stream = OutputDataStream()
            stream.write(1234 as UInt16, endianess: .bigEndian)
            XCTAssertEqualHex([0x04, 0xD2], [UInt8](stream.data))
        }
        do {
            var stream = OutputDataStream()
            stream.write(1234 as UInt16, endianess: .littleEndian)
            XCTAssertEqualHex([0xD2, 0x04], [UInt8](stream.data))
        }
    }

    func testWriteInt16() {
        do {
            var stream = OutputDataStream()
            stream.write(1234 as Int16, endianess: .systemDefault)
            XCTAssertEqualHex([0xD2, 0x04], [UInt8](stream.data))
        }
        do {
            var stream = OutputDataStream()
            stream.write(1234 as Int16, endianess: .bigEndian)
            XCTAssertEqualHex([0x04, 0xD2], [UInt8](stream.data))
        }
        do {
            var stream = OutputDataStream()
            stream.write(1234 as Int16, endianess: .littleEndian)
            XCTAssertEqualHex([0xD2, 0x04], [UInt8](stream.data))
        }
    }

    func testWriteUInt32() {
        do {
            var stream = OutputDataStream()
            stream.write(1234 as UInt32, endianess: .systemDefault)
            XCTAssertEqualHex([0xD2, 0x04, 0x00, 0x00], [UInt8](stream.data))
        }
        do {
            var stream = OutputDataStream()
            stream.write(1234 as UInt32, endianess: .bigEndian)
            XCTAssertEqualHex([0x00, 0x00, 0x04, 0xD2], [UInt8](stream.data))
        }
        do {
            var stream = OutputDataStream()
            stream.write(1234 as UInt32, endianess: .littleEndian)
            XCTAssertEqualHex([0xD2, 0x04, 0x00, 0x00], [UInt8](stream.data))
        }
    }

    func testWriteInt32() {
        do {
            var stream = OutputDataStream()
            stream.write(1234 as Int32, endianess: .systemDefault)
            XCTAssertEqualHex([0xD2, 0x04, 0x00, 0x00], [UInt8](stream.data))
        }
        do {
            var stream = OutputDataStream()
            stream.write(1234 as Int32, endianess: .bigEndian)
            XCTAssertEqualHex([0x00, 0x00, 0x04, 0xD2], [UInt8](stream.data))
        }
        do {
            var stream = OutputDataStream()
            stream.write(1234 as Int32, endianess: .littleEndian)
            XCTAssertEqualHex([0xD2, 0x04, 0x00, 0x00], [UInt8](stream.data))
        }
    }

    func testWriteUInt64() {
        do {
            var stream = OutputDataStream()
            stream.write(1234 as UInt64, endianess: .systemDefault)
            XCTAssertEqualHex([0xD2, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00], [UInt8](stream.data))
        }
        do {
            var stream = OutputDataStream()
            stream.write(1234 as UInt64, endianess: .bigEndian)
            XCTAssertEqualHex([0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0xD2], [UInt8](stream.data))
        }
        do {
            var stream = OutputDataStream()
            stream.write(1234 as UInt64, endianess: .littleEndian)
            XCTAssertEqualHex([0xD2, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00], [UInt8](stream.data))
        }
    }

    func testWriteInt64() {
        do {
            var stream = OutputDataStream()
            stream.write(1234 as Int64, endianess: .systemDefault)
            XCTAssertEqualHex([0xD2, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00], [UInt8](stream.data))
        }
        do {
            var stream = OutputDataStream()
            stream.write(1234 as Int64, endianess: .bigEndian)
            XCTAssertEqualHex([0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0xD2], [UInt8](stream.data))
        }
        do {
            var stream = OutputDataStream()
            stream.write(1234 as Int64, endianess: .littleEndian)
            XCTAssertEqualHex([0xD2, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00], [UInt8](stream.data))
        }
    }

    func testWriteFloat() {
        do {
            var stream = OutputDataStream()
            stream.write(1234.456 as Float, endianess: .systemDefault)
            XCTAssertEqualHex([0x98, 0x4E, 0x9A, 0x44], [UInt8](stream.data))
        }
        do {
            var stream = OutputDataStream()
            stream.write(1234.456 as Float, endianess: .bigEndian)
            XCTAssertEqualHex([0x44, 0x9A, 0x4E, 0x98], [UInt8](stream.data))
        }
        do {
            var stream = OutputDataStream()
            stream.write(1234.456 as Float, endianess: .littleEndian)
            XCTAssertEqualHex([0x98, 0x4E, 0x9A, 0x44], [UInt8](stream.data))
        }
    }

    func testWriteDouble() {
        do {
            var stream = OutputDataStream()
            stream.write(1234.456 as Double, endianess: .systemDefault)
            XCTAssertEqualHex([0xE7, 0xFB, 0xA9, 0xF1, 0xD2, 0x49, 0x93, 0x40], [UInt8](stream.data))
        }
        do {
            var stream = OutputDataStream()
            stream.write(1234.456 as Double, endianess: .bigEndian)
            XCTAssertEqualHex([0x40, 0x93, 0x49, 0xD2, 0xF1, 0xA9, 0xFB, 0xE7], [UInt8](stream.data))
        }
        do {
            var stream = OutputDataStream()
            stream.write(1234.456 as Double, endianess: .littleEndian)
            XCTAssertEqualHex([0xE7, 0xFB, 0xA9, 0xF1, 0xD2, 0x49, 0x93, 0x40], [UInt8](stream.data))
        }
    }

    func testWriteBytes() {
        do {
            var stream = OutputDataStream()
            stream.write([])
            XCTAssertEqualHex([], [UInt8](stream.data))
        }
        do {
            var stream = OutputDataStream()
            stream.write([0x01, 0x02, 0x03])
            XCTAssertEqualHex([0x01, 0x02, 0x03], [UInt8](stream.data))
        }
    }

    func testWriteData() {
        do {
            var stream = OutputDataStream()
            stream.write(Data([]))
            XCTAssertEqualHex([], [UInt8](stream.data))
        }
        do {
            var stream = OutputDataStream()
            stream.write(Data([0x01, 0x02, 0x03]))
            XCTAssertEqualHex([0x01, 0x02, 0x03], [UInt8](stream.data))
        }
    }

    func testWriteString() {
        do {
            var stream = OutputDataStream()
            stream.write("", encoding: .ascii)
            XCTAssertEqualHex([], [UInt8](stream.data))
        }
        do {
            var stream = OutputDataStream()
            stream.write("abc", encoding: .ascii)
            XCTAssertEqualHex([0x61, 0x62, 0x63], [UInt8](stream.data))
        }
        do {
            var stream = OutputDataStream()
            stream.write("abc", encoding: .utf16)
            XCTAssertEqualHex([0xFF, 0xFE, 0x61, 0x00, 0x62, 0x00, 0x63, 0x00], [UInt8](stream.data))
        }
        do {
            var stream = OutputDataStream()
            stream.write("abc", encoding: .utf16LittleEndian)
            XCTAssertEqualHex([0x61, 0x00, 0x62, 0x00, 0x63, 0x00], [UInt8](stream.data))
        }
        do {
            var stream = OutputDataStream()
            stream.write("abc", encoding: .utf16BigEndian)
            XCTAssertEqualHex([0x00, 0x61, 0x00, 0x62, 0x00, 0x63], [UInt8](stream.data))
        }
    }

    func testWriteUUID() {
        do {
            var stream = OutputDataStream()
            let uuid = UUID(uuidString: "E621E1F8-C36C-495A-93FC-0C247A3E6E5F")!
            stream.write(uuid)
            XCTAssertEqualHex([0xE6, 0x21, 0xE1, 0xF8, 0xC3, 0x6C, 0x49, 0x5A, 0x93, 0xFC, 0x0C, 0x24, 0x7A, 0x3E, 0x6E, 0x5F], [UInt8](stream.data))
        }
    }

    static var allTests = [
        ("testWriteUInt8", testWriteUInt8),
        ("testWriteInt8", testWriteInt8),
        ("testWriteUInt16", testWriteUInt16),
        ("testWriteInt16", testWriteInt16),
        ("testWriteUInt32", testWriteUInt32),
        ("testWriteInt32", testWriteInt32),
        ("testWriteUInt64", testWriteUInt64),
        ("testWriteInt64", testWriteInt64),
        ("testWriteFloat", testWriteFloat),
        ("testWriteDouble", testWriteDouble),
        ("testWriteString", testWriteString),
        ("testWriteBytes", testWriteBytes),
        ("testWriteUUID", testWriteUUID),
    ]
}
