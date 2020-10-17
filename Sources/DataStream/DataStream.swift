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
    public let data: Data
    private var _offset: Int = 0
    
    public init(buffer: [UInt8]) {
        self.init(data: Data(buffer))
    }
    
    public init(data: Data) {
        self.data = data
    }
    
    public var position: Int {
        get {
            return _offset
        } set {
            precondition(newValue >= 0 && newValue <= data.count)
            _offset = newValue
        }
    }
    
    public var count: Int {
        return data.count
    }
    
    public var remainingCount: Int {
        return count - position
    }
    
    public var remainingData: Data {
        return data[position...]
    }
    
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
    
    public mutating func readBytes(count: Int) throws -> [UInt8] {
        var result = [UInt8](repeating: 0, count: count)
        try result.withUnsafeMutableBufferPointer {
            try copyBytes(to: $0, count: count)
        }
        return result
    }

    public mutating func readString(count: Int, encoding: String.Encoding) throws -> String? {
        let bytes = try readBytes(count: count)
        return String(bytes: bytes, encoding: encoding)
    }
    
    public mutating func readUnicodeString(endianess: Endianess) throws -> String? {
        let position = self.position
        var count = 0
        while (try read(endianess: endianess) as UInt16 != 0) {
            count += 1
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
        return String(data: data[position...position + count * 2], encoding: encoding)
    }

    public mutating func readAsciiString() throws -> String? {
        let position = self.position
        var count = 0
        while (try read() as UInt8 != 0) {
            count += 1
        }
        
        return String(data: data[position...position + count], encoding: .ascii)
    }

    
    public mutating func read<T>(type: T.Type) throws -> T {
        let size = MemoryLayout<T>.size
        if position + size > count {
            throw DataStreamError.noSpace(position: position, count: size)
        }

        let result = data.withUnsafeBytes {
            return $0.baseAddress?.advanced(by: position).assumingMemoryBound(to: T.self).pointee
        }!
        position += size
        return result
    }
    
    public mutating func copyBytes(to pointer: UnsafeMutableBufferPointer<UInt8>, count: Int) throws {
        if position + count > self.count {
            throw DataStreamError.noSpace(position: position, count: count)
        }

        data.copyBytes(to: pointer, from: position..<position + count)
        position += count
    }
}
