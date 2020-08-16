//
//  OutputDataStream.swift
//
//
//  Created by Hugh Bellamy on 20/07/2020.
//
//

import Foundation

public struct OutputDataStream {
    public var data: Data
    private var _offset: Int = 0
    
    public init() {
        self.init(data: Data())
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
    
    public mutating func write(_ value: UInt8) {
        data.insert(value, at: position)
        position += 1
    }
    
    public mutating func write<T>(_ value: T, endianess: Endianess) where T: FixedWidthInteger {
        var buffer: T
        switch endianess {
        case .systemDefault:
            buffer = value
        case .littleEndian:
            buffer = value.littleEndian
        case .bigEndian:
            buffer = value.bigEndian
        }
        withUnsafeBytes(of: &buffer) {
            data.insert(contentsOf: $0, at: position)
            position += $0.count
        }
    }
    
    public mutating func write(_ value: Float, endianess: Endianess) {
        write(value.bitPattern, endianess: endianess)
    }
    
    public mutating func write(_ value: Double, endianess: Endianess) {
        write(value.bitPattern, endianess: endianess)
    }

    public mutating func write(_ value: [UInt8]) {
        data.insert(contentsOf: value, at: position)
        position += value.count
    }
    
    public mutating func write(_ value: Data) {
        data.insert(contentsOf: value, at: position)
        position += value.count
    }

    public mutating func write(_ value: String, encoding: String.Encoding) {
        guard let bytes = value.data(using: encoding) else {
            fatalError("Could not get bytes")
        }
        
        write(bytes)
    }
    
    public mutating func write(_ value: UUID) {
        let uuid = value.uuid
        write(uuid.0)
        write(uuid.1)
        write(uuid.2)
        write(uuid.3)
        write(uuid.4)
        write(uuid.5)
        write(uuid.6)
        write(uuid.7)
        write(uuid.8)
        write(uuid.9)
        write(uuid.10)
        write(uuid.11)
        write(uuid.12)
        write(uuid.13)
        write(uuid.14)
        write(uuid.15)
    }
}
