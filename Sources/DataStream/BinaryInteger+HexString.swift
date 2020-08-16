//
//  DumpExtensions.swift
//
//
//  Created by Hugh Bellamy on 20/07/2020.
//
//

public extension BinaryInteger {
    var hexString: String {
        return "0x\(String(self, radix: 16, uppercase: true).padLeft(toLength: MemoryLayout<Self>.size * 2, withPad: "0"))"
    }
}
