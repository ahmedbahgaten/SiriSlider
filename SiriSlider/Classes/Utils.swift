//
//  Utils.swift
//  SiriSlider
//
//  Created by Ahmed Bahgat on 07/03/2024.
//

import Foundation
public extension Comparable {
  func clamped(to range: ClosedRange<Self>) -> Self {
    return min(max(range.lowerBound, self), range.upperBound)
  }
}
