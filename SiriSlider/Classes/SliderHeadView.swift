//
//  SliderHeadView.swift
//  SiriSlider
//
//  Created by Ahmed Bahgat on 07/03/2024.
//

import Foundation
import UIKit

public class SliderHeadView:UIView {
  var moveStartingPoint:CGPoint = .init(x: 0, y: 0)
    //MARK: - init
  init() {
    super.init(frame: .zero)
  }
  
  required init?(coder: NSCoder) {
    super.init(frame: .zero)
  }
}
