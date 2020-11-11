//
//  BitFieldReader.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import BitField

public struct BitFieldReader<T> where T: FixedWidthInteger {
    public var bitField: BitField<T>
    public var rawValue: T { bitField.rawValue }
    
    private var _position: Int = 0

    public var position: Int {
        get { _position }
        set {
            precondition(newValue >= 0 && newValue <= T.bitWidth)
            _position = newValue
        }
    }
    
    public var count: Int { T.bitWidth }
    
    public var remainingCount: Int { count - position }
    
    public init(rawValue: T) {
        self.bitField = BitField(rawValue: rawValue)
    }
    
    public init(bitField: BitField<T>) {
        self.bitField = bitField
    }
    
    public mutating func readBit() -> Bool {
        let result = bitField.getBit(position)
        position += 1
        return result
    }
    
    public mutating func readBits(count: Int) -> T {
        let result = bitField.getBits(offset: position, count: count)
        position += count
        return result
    }
    
    public mutating func readRemainingBits() -> T {
        let result = bitField.getBits(offset: position, count: remainingCount)
        position += remainingCount
        return result
    }
}
