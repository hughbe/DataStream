//
//  DumpExtensions.swift
//
//
//  Created by Hugh Bellamy on 20/07/2020.
//
//

public extension BinaryInteger {
    var hexString: String {
        if self < 0 {
            return String(self)
        }

        return "0x\(String(self, radix: 16, uppercase: true).padLeft(toLength: MemoryLayout<Self>.size * 2, withPad: "0"))"
    }
}

public extension Sequence where Element: FixedWidthInteger {
    var hexString: String {
        return "[\(map { $0.hexString }.joined(separator: ", "))]"
    }
}
