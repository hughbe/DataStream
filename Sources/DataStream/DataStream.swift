//
//  DataExtensions.swift
//  MsgViewer
//
//  Created by Hugh Bellamy on 20/07/2020.
//  Copyright © 2020 Hugh Bellamy. All rights reserved.
//

import Foundation

public enum DataStreamError: Error {
    case noSpace(position: Int, count: Int)
}

public struct DataStream {
    public let data: Data
    private var _offset: Int = 0
    
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
    
    public mutating func readUInt8() throws -> UInt8 {
        return try read(type: UInt8.self)
    }
    
    public mutating func readUInt16() throws -> UInt16 {
        return try read(type: UInt16.self)
    }
    
    public mutating func readUInt32() throws -> UInt32 {
        return try read(type: UInt32.self)
    }
    
    public mutating func readUInt64() throws -> UInt64 {
        return try read(type: UInt64.self)
    }
    
    public mutating func readBytes(count: Int) throws -> [UInt8] {
        var result = [UInt8](repeating: 0, count: count)
        try result.withUnsafeMutableBufferPointer {
            try copyBytes(to: $0, count: count)
        }
        return result
    }
    
    public mutating func read<T>(type: T.Type) throws -> T {
        let size = MemoryLayout<T>.size
        if position + size > count {
            throw DataStreamError.noSpace(position: position, count: size)
        }

        let result = data.advanced(by: position).withUnsafeBytes { $0.load(fromByteOffset: 0, as: type) }
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
