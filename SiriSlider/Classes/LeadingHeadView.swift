//
//  LeadingHeadView.swift
//  SiriSlider
//
//  Created by Ahmed Bahgat on 07/03/2024.
//

import Foundation
import UIKit
import Combine

public class LeadingHeadView:SliderHeadView {
  
    //MARK: - Properties
  private let newXValueSubject:PassthroughSubject<CGFloat,Never> = .init()
  private let onFocusSubject:PassthroughSubject<Bool,Never> = .init()
  
  var newXValuePublisher:AnyPublisher<CGFloat,Never> {
    newXValueSubject.eraseToAnyPublisher()
  }
  var onFocusPublisher:AnyPublisher<Bool,Never> {
    onFocusSubject.eraseToAnyPublisher()
  }
    //MARK: - inits
  override init() {
    super.init()
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
    addGestureRecognizer(panGesture)
  }
  
  required init?(coder: NSCoder) {
    super.init()
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
    addGestureRecognizer(panGesture)
  }
    //MARK: - Methods
  @objc
  private func handlePan(_ gesture: UIPanGestureRecognizer) {
    if gesture.state == .began {
      moveStartingPoint = frame.origin
      onFocusSubject.send(true)
    }else if gesture.state == .changed {
      let translation = gesture.translation(in: superview)
      let minPoint = getMinXPoint()
      let maxPoint = getMaxXPoint()
      let newOriginX = (moveStartingPoint.x + translation.x).clamped(to: minPoint...maxPoint)
      let finalValue = RTLHandler.shared.isRTL() ? (maxPoint - newOriginX) : newOriginX
      newXValueSubject.send(finalValue)
    }else if gesture.state == .ended {
      onFocusSubject.send(false)
    }
  }
  
  func getMinXPoint() -> CGFloat {
    guard let superView = superview else { return 0 }
    guard let theOtherHead = (superView.subviews.first { $0 is TrailingHeadView }) else { return 0 }
    
    if RTLHandler.shared.isRTL() {
      return theOtherHead.frame.minX
    }else {
      return superView.bounds.origin.x
    }
  }
  
  func getMaxXPoint() -> CGFloat {
    guard let superView = superview else { return 0 }
    guard let theOtherHead = (superView.subviews.first { $0 is TrailingHeadView }) else { return 0 }
    if RTLHandler.shared.isRTL() {
      return superView.frame.size.width - frame.size.width
    }else {
      return theOtherHead.frame.minX
    }
  }
  
  func getHeadPosition() -> Double {
    guard let superView = superview else { return 0 }
    if RTLHandler.shared.isRTL() {
      return Double(superView.frame.size.width - (frame.midX)).rounded(.up)
    }else {
      return Double(frame.midX).rounded(.up)
    }
  }
}
