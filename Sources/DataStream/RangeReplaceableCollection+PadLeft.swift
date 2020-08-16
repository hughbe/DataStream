//
//  RangeReplaceableCollection+PadLeft.swift
//
//  Created by Hugh Bellamy on 24/07/2020.
//
//

import Foundation

public extension RangeReplaceableCollection where Self: StringProtocol {
    func padLeft(toLength length: Int, withPad padString: Element) -> SubSequence {
        return repeatElement(padString, count: Swift.max(0, length - count)) + suffix(Swift.max(count, count - length))
    }
}
