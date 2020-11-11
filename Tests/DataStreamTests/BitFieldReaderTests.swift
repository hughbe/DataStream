import XCTest
import BitField
@testable import DataStream

final class BitFieldReaderTests: XCTestCase {
    func testConstructorT() {
        let rawValue: UInt8 = 0b00000001
        let reader = BitFieldReader(rawValue: rawValue)
        XCTAssertEqual(0b00000001, reader.rawValue)
        XCTAssertEqual(0b00000001, reader.bitField.rawValue)
        XCTAssertEqual(0, reader.position)
        XCTAssertEqual(8, reader.count)
        XCTAssertEqual(8, reader.remainingCount)
    }

    func testConstructorBitFieldT() {
        let bitField = BitField(rawValue: 0b00000001 as UInt8)
        let reader = BitFieldReader(bitField: bitField)
        XCTAssertEqual(0b00000001, reader.rawValue)
        XCTAssertEqual(0b00000001, reader.bitField.rawValue)
        XCTAssertEqual(0, reader.position)
        XCTAssertEqual(8, reader.count)
        XCTAssertEqual(8, reader.remainingCount)
    }
    
    func testReadBit() throws {
        do {
            let rawValue: UInt8 = 0b00000001
            var reader = BitFieldReader(rawValue: rawValue)
            XCTAssertTrue(reader.readBit())
            XCTAssertEqual(1, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(2, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(3, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(4, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(5, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(6, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(7, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(8, reader.position)
        }
        do {
            let rawValue: UInt8 = 0b00000010
            var reader = BitFieldReader(rawValue: rawValue)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(1, reader.position)
            XCTAssertTrue(reader.readBit())
            XCTAssertEqual(2, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(3, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(4, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(5, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(6, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(7, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(8, reader.position)
        }
        do {
            let rawValue: UInt8 = 0b00000100
            var reader = BitFieldReader(rawValue: rawValue)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(1, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(2, reader.position)
            XCTAssertTrue(reader.readBit())
            XCTAssertEqual(3, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(4, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(5, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(6, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(7, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(8, reader.position)
        }
        do {
            let rawValue: UInt8 = 0b00001000
            var reader = BitFieldReader(rawValue: rawValue)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(1, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(2, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(3, reader.position)
            XCTAssertTrue(reader.readBit())
            XCTAssertEqual(4, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(5, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(6, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(7, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(8, reader.position)
        }
        do {
            let rawValue: UInt8 = 0b00010000
            var reader = BitFieldReader(rawValue: rawValue)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(1, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(2, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(3, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(4, reader.position)
            XCTAssertTrue(reader.readBit())
            XCTAssertEqual(5, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(6, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(7, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(8, reader.position)
        }
        do {
            let rawValue: UInt8 = 0b00100000
            var reader = BitFieldReader(rawValue: rawValue)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(1, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(2, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(3, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(4, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(5, reader.position)
            XCTAssertTrue(reader.readBit())
            XCTAssertEqual(6, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(7, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(8, reader.position)
        }
        do {
            let rawValue: UInt8 = 0b01000000
            var reader = BitFieldReader(rawValue: rawValue)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(1, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(2, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(3, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(4, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(5, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(6, reader.position)
            XCTAssertTrue(reader.readBit())
            XCTAssertEqual(7, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(8, reader.position)
        }
        do {
            let rawValue: UInt8 = 0b10000000
            var reader = BitFieldReader(rawValue: rawValue)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(1, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(2, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(3, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(4, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(5, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(6, reader.position)
            XCTAssertFalse(reader.readBit())
            XCTAssertEqual(7, reader.position)
            XCTAssertTrue(reader.readBit())
            XCTAssertEqual(8, reader.position)
        }
    }
    
    func testReadBits() throws {
        do {
            let rawValue: UInt8 = 0b10101010
            var reader = BitFieldReader(rawValue: rawValue)
            XCTAssertEqual(0b10101010, reader.readBits(count: 8))
            XCTAssertEqual(8, reader.position)
        }
        do {
            let rawValue: UInt8 = 0b10101010
            var reader = BitFieldReader(rawValue: rawValue)
            XCTAssertEqual(0b010, reader.readBits(count: 3))
            XCTAssertEqual(3, reader.position)
            XCTAssertEqual(0b01, reader.readBits(count: 2))
            XCTAssertEqual(5, reader.position)
            XCTAssertEqual(0b1, reader.readBits(count: 1))
            XCTAssertEqual(6, reader.position)
            XCTAssertEqual(0b10, reader.readBits(count: 2))
            XCTAssertEqual(8, reader.position)
        }
    }
    
    func testReadRemainingBits() throws {
        do {
            let rawValue: UInt8 = 0b10101010
            var reader = BitFieldReader(rawValue: rawValue)
            XCTAssertEqual(0b10101010, reader.readRemainingBits())
            XCTAssertEqual(8, reader.position)
            XCTAssertEqual(0, reader.remainingCount)
        }
        do {
            let rawValue: UInt8 = 0b10101010
            var reader = BitFieldReader(rawValue: rawValue)
            XCTAssertEqual(0b010, reader.readBits(count: 3))
            XCTAssertEqual(3, reader.position)
            XCTAssertEqual(5, reader.remainingCount)
            XCTAssertEqual(0b10101, reader.readRemainingBits())
        }
    }
    
    func testPosition() {
        let rawValue: UInt8 = 0b10101010
        var reader = BitFieldReader(rawValue: rawValue)
        
        reader.position = 7
        XCTAssertEqual(7, reader.position)
        XCTAssertEqual(1, reader.remainingCount)
        XCTAssertTrue(reader.readBit())
        
        reader.position = 8
        XCTAssertEqual(8, reader.position)
        XCTAssertEqual(0, reader.remainingCount)
        
        reader.position = 0
        XCTAssertEqual(0, reader.position)
        XCTAssertEqual(8, reader.remainingCount)
        XCTAssertFalse(reader.readBit())
        
        reader.position = 1
        XCTAssertEqual(1, reader.position)
        XCTAssertEqual(7, reader.remainingCount)
        XCTAssertTrue(reader.readBit())
    }

    static var allTests = [
        ("testConstructorT", testConstructorT),
        ("testConstructorBitFieldT", testConstructorBitFieldT),
        ("testReadBit", testReadBit),
        ("testReadBits", testReadBits),
        ("testReadRemainingBits", testReadRemainingBits),
        ("testPosition", testPosition),
    ]
}
