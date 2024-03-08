//
//  ViewController.swift
//  SiriSlider
//
//  Created by ahmedbahgaten on 03/07/2024.
//  Copyright (c) 2024 ahmedbahgaten. All rights reserved.
//

import UIKit
import SiriSlider

class ViewController: UIViewController {

  @IBOutlet weak var siriSlider: SiriSliderView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configSlider()
  }
  
  private func configSlider() {
    let sliderConfig = SiriSliderConfiguration()
    sliderConfig.labelTextColor = .systemBlue
    sliderConfig.headColor = .lightGray
    sliderConfig.headSize = CGSize(width: 20, height: 20)
    sliderConfig.headRadius = 10
    sliderConfig.minPointValue = 0
    sliderConfig.maxPointValue = 150
    sliderConfig.startAt = 80
    sliderConfig.endAt = 140
    sliderConfig.labelPosition = .top
    sliderConfig.outerTrackHeight = 2
    sliderConfig.outerTrackColor = .lightGray
    sliderConfig.innerTrackColor = .systemBlue
    sliderConfig.innerTrackHeight = 2
    siriSlider.setConfig(config: sliderConfig)
  }
}

