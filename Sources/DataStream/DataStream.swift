//
//  DataExtensions.swift
//
//
//  Created by Hugh Bellamy on 20/07/2020.
//
//

import Foundation

public enum DataStreamError: Error {
    case noSpace(position: Int, count: Int)
}

public struct DataStream {
    private let data: Data
    public let startIndex: Int
    public let count: Int
    private var _actualPosition: Int
    
    public init(_ buffer: [UInt8]) {
        self.init(Data(buffer))
    }
    
    public init(_ data: [UInt8], startIndex: Int, count: Int) {
        self.init(Data(data), startIndex: startIndex, count: count)
    }
    
    public init(slicing dataStream: DataStream, startIndex: Int, count: Int) {
        precondition(startIndex >= 0)
        precondition(count >= 0)
        precondition(startIndex <= dataStream.count - count)
        
        self.startIndex = dataStream.startIndex + startIndex
        self.count = count
        self.data = dataStream.data
        self._actualPosition = dataStream.startIndex + startIndex
    }
    
    public init(_ data: Data) {
        self.init(data, startIndex: 0, count: data.count)
    }
    
    public init(_ data: Data, startIndex: Int, count: Int) {
        precondition(startIndex >= 0)
        precondition(count >= 0)
        precondition(startIndex <= data.count - count)
        
        self.startIndex = startIndex
        self.count = count
        self.data = data
        self._actualPosition = startIndex
    }
    
    public var position: Int {
        get {  _actualPosition - startIndex } set {
            precondition(newValue >= 0 && newValue <= count)
            _actualPosition = newValue + startIndex
        }
    }
    
    public var remainingCount: Int { count - position }
    
    public var remainingData: Data { data[_actualPosition..<(_actualPosition + count)] }
    
    public mutating func read<T>(endianess: Endianess = .systemDefault) throws -> T where T: FixedWidthInteger {
        let value = try read(type: T.self)
        switch endianess {
        case .systemDefault:
            return value
        case .littleEndian:
            return T(littleEndian: value)
        case .bigEndian:
            return T(bigEndian: value)
        }
    }
    
    public func peek<T>(endianess: Endianess = .systemDefault) throws -> T where T: FixedWidthInteger {
        let value = try peek(type: T.self)
        switch endianess {
        case .systemDefault:
            return value
        case .littleEndian:
            return T(littleEndian: value)
        case .bigEndian:
            return T(bigEndian: value)
        }
    }
    
    public mutating func readBits<T>(endianess: Endianess = .systemDefault) throws -> BitFieldReader<T> where T: FixedWidthInteger {
        return BitFieldReader(rawValue: try read(endianess: endianess))
    }
    
    public func peekBits<T>(endianess: Endianess = .systemDefault) throws -> BitFieldReader<T> where T: FixedWidthInteger {
        return BitFieldReader(rawValue: try peek(endianess: endianess))
    }
    
    public mutating func readFloat(endianess: Endianess = .systemDefault) throws -> Float {
        let value = try read(type: Float.self)
        switch endianess {
        case .systemDefault:
            return value
        case .littleEndian:
            return Float(bitPattern: value.bitPattern.littleEndian)
        case .bigEndian:
            return Float(bitPattern: value.bitPattern.bigEndian)
        }
    }
    
    public func peekFloat(endianess: Endianess = .systemDefault) throws -> Float {
        let value = try peek(type: Float.self)
        switch endianess {
        case .systemDefault:
            return value
        case .littleEndian:
            return Float(bitPattern: value.bitPattern.littleEndian)
        case .bigEndian:
            return Float(bitPattern: value.bitPattern.bigEndian)
        }
    }
    
    public mutating func readDouble(endianess: Endianess = .systemDefault) throws -> Double {
        let value = try read(type: Double.self)
        switch endianess {
        case .systemDefault:
            return value
        case .littleEndian:
            return Double(bitPattern: value.bitPattern.littleEndian)
        case .bigEndian:
            return Double(bitPattern: value.bitPattern.bigEndian)
        }
    }
    
    public func peekDouble(endianess: Endianess = .systemDefault) throws -> Double {
        let value = try peek(type: Double.self)
        switch endianess {
        case .systemDefault:
            return value
        case .littleEndian:
            return Double(bitPattern: value.bitPattern.littleEndian)
        case .bigEndian:
            return Double(bitPattern: value.bitPattern.bigEndian)
        }
    }
    
    public mutating func readBytes(count: Int) throws -> [UInt8] {
        var result = [UInt8](repeating: 0, count: count)
        try result.withUnsafeMutableBufferPointer {
            try readBytes(to: $0, count: count)
        }
        return result
    }
    
    public func peekBytes(count: Int) throws -> [UInt8] {
        var result = [UInt8](repeating: 0, count: count)
        try result.withUnsafeMutableBufferPointer {
            try peekBytes(to: $0, count: count)
        }
        return result
    }

    public mutating func readString(count: Int, encoding: String.Encoding) throws -> String? {
        let bytes = try readBytes(count: count)
        return String(bytes: bytes, encoding: encoding)
    }
    
    public func peekString(count: Int, encoding: String.Encoding) throws -> String? {
        let bytes = try peekBytes(count: count)
        return String(bytes: bytes, encoding: encoding)
    }
    
    public mutating func readUnicodeString(endianess: Endianess = .systemDefault) throws -> String? {
        let position = _actualPosition
        var count = 0
        while (try read(endianess: endianess) as UInt16 != 0) {
            count += 1
        }
        
        if count == 0 {
            return ""
        }
        
        let encoding: String.Encoding
        switch endianess {
        case .littleEndian:
            encoding = .utf16LittleEndian
        case .bigEndian:
            encoding = .utf16BigEndian
        case .systemDefault:
            encoding = .utf16
        }

        return String(data: data[data.startIndex + position..<data.startIndex + position + count * 2], encoding: encoding)
    }
    
    public mutating func peekUnicodeString(endianess: Endianess = .systemDefault) throws -> String? {
        let position = self.position
        let result = try readUnicodeString(endianess: endianess)
        self.position = position
        return result
    }

    public mutating func readAsciiString() throws -> String? {
        let position = _actualPosition
        var count = 0
        while (try read() as UInt8 != 0) {
            count += 1
        }
        
        if count == 0 {
            return ""
        }
        
        return String(data: data[data.startIndex + position..<data.startIndex + position + count], encoding: .ascii)
    }
    
    public mutating func peekAsciiString() throws -> String? {
        let position = self.position
        let result = try readAsciiString()
        self.position = position
        return result
    }

    public mutating func read<T>(type: T.Type) throws -> T {
        let result = try peek(type: type)
        position += MemoryLayout<T>.size
        return result
    }
    
    public func peek<T>(type: T.Type) throws -> T {
        let size = MemoryLayout<T>.size
        if _actualPosition + size > startIndex + count {
            throw DataStreamError.noSpace(position: position, count: size)
        }

        return data.withUnsafeBytes {
            return $0.baseAddress?.advanced(by: _actualPosition).assumingMemoryBound(to: T.self).pointee
        }!
    }
    
    public mutating func readDataStream(count: Int) throws -> DataStream {
        let result = try peekDataStream(count: count)
        position += count
        return result
    }
    
    public func peekDataStream(count: Int) throws -> DataStream {
        if _actualPosition + count > startIndex + self.count {
            throw DataStreamError.noSpace(position: position, count: count)
        }

        return DataStream(data, startIndex: position, count: count)
    }
    
    public mutating func readBytes(to pointer: UnsafeMutableBufferPointer<UInt8>, count: Int) throws {
        try peekBytes(to: pointer, count: count)
        position += count
    }
    
    public func peekBytes(to pointer: UnsafeMutableBufferPointer<UInt8>, count: Int) throws {
        if _actualPosition + count > startIndex + self.count {
            throw DataStreamError.noSpace(position: position, count: count)
        }
        if count == 0 {
            return
        }

        data.copyBytes(to: pointer, from: data.startIndex + _actualPosition..<data.startIndex + _actualPosition + count)
    }
    
    public mutating func skip(count: Int) throws {
        if _actualPosition + count > startIndex + self.count {
            throw DataStreamError.noSpace(position: position, count: count)
        }

        position += count
    }
}
