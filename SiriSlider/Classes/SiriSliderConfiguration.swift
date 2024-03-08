//
//  SiriSliderConfiguration.swift
//  SiriSlider
//
//  Created by Ahmed Bahgat on 08/03/2024.
//

import Foundation
public class SiriSliderConfiguration {
  
  public init() {}
  
  public var showLabels:Bool = true
  public var labelPosition: LabelPosition = .top
  public var labelOffset:CGFloat = 5
  public var labelFontSize:CGFloat = 12
  public var labelTextColor:UIColor = .black
  public var labelBackgroundColor:UIColor = .clear
  public var headColor:UIColor = .red
  public var headSize:CGSize = CGSize(width: 40, height: 40)
  public var headRadius:CGFloat = 10
  public var minPointValue:Double = 0
  public var maxPointValue:Double = 100
  public var backgroundColor:UIColor = .clear
  public var alwaysShowLabels:Bool = false
  public var outerTrackColor:UIColor = .gray
  public var innerTrackColor:UIColor = .blue
  
  public var outerTrackHeight:CGFloat = 2
  public var innerTrackHeight:CGFloat = 2
  
  public var customLeadingLabel:UILabel?
  public var customTrailingLabel:UILabel?
  
  public var startAt:CGFloat?
  public var endAt:CGFloat?
  public var customLeadingView:LeadingHeadView?
  public var customTrailingView:TrailingHeadView?
  
  public enum LabelPosition {
    case top
    case bottom
  }
  
  
}
