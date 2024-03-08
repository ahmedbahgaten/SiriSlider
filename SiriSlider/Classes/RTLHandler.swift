//
//  RTLHandler.swift
//  SiriSlider
//
//  Created by Ahmed Bahgat on 07/03/2024.
//

import Foundation
public class RTLHandler {
  private init() {}
  static let shared = RTLHandler()
  
  func isRTL() -> Bool {
    UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
  }
  
}
