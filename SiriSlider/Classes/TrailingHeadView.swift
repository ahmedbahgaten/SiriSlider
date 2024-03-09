//
//  TrailingHeadView.swift
//  SiriSlider
//
//  Created by Ahmed Bahgat on 07/03/2024.
//

import Foundation
import UIKit
import Combine

public class TrailingHeadView:SliderHeadView {
    //MARK: - Properties
  private let newXValueSubject:PassthroughSubject<CGFloat,Never> = .init()
  private let onFocusSubject:PassthroughSubject<Bool,Never> = .init()
  
  var newXValuePublisher:AnyPublisher<CGFloat,Never> {
    newXValueSubject.eraseToAnyPublisher()
  }
  var onFocusPublisher:AnyPublisher<Bool,Never> {
    onFocusSubject.eraseToAnyPublisher()
  }
    //MARK: - Inits
  override init() {
    super.init()
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
    addGestureRecognizer(panGesture)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    //MARK: - Methods
  @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
    if gesture.state == .began {
      moveStartingPoint = frame.origin
      onFocusSubject.send(true)
    }else if gesture.state == .changed {
      let translation = gesture.translation(in: superview)
      let minPoint = getMinXPoint()
      let maxPoint = getMaxXPoint()
      let newOriginX = (moveStartingPoint.x + translation.x).clamped(to: minPoint...maxPoint)
      let finalValue = RTLHandler.shared.isRTL() ? newOriginX : (maxPoint - newOriginX)
      newXValueSubject.send(finalValue)
    }else if gesture.state == .ended {
      onFocusSubject.send(false)
    }
  }
  
  private func getMinXPoint() -> CGFloat {
    guard let superView = superview else { return 0 }
    guard let theOtherHead = (superView.subviews.first { $0 is LeadingHeadView }) else { return 0 }
    
    if RTLHandler.shared.isRTL() {
      return superView.bounds.origin.x
    }else {
      return theOtherHead.frame.minX
    }
  }
  
  private func getMaxXPoint() -> CGFloat {
    guard let superView = superview else { return 0 }
    guard let theOtherHead = (superView.subviews.first { $0 is LeadingHeadView }) else { return 0 }
    
    if RTLHandler.shared.isRTL() {
      return theOtherHead.frame.minX
    }else {
      return superView.frame.size.width - frame.size.width
    }
  }
  
  private func getHeadPosition() -> Double {
    guard let superView = superview else { return 0 }
    if RTLHandler.shared.isRTL() {
      return Double(superView.frame.size.width - frame.midX).rounded(.up)
    }else {
      return Double(frame.midX).rounded(.up)
    }
  }
  
  func getReading(minValue:Double,maxValue:Double) -> Double {
    guard let superView = superview as? SiriSliderView else { return 0 }
    let leadingHeadWidth = frame.size.width / 2
    var position = getHeadPosition()
    let sliderFrame = superView.frame.size.width
    if position == sliderFrame - leadingHeadWidth {
      position += leadingHeadWidth
    }else if position == leadingHeadWidth {
      position -= leadingHeadWidth
    }
    let ratio = position / sliderFrame
    return (minValue + (ratio * (maxValue - minValue))).rounded(.down)
  }
}
