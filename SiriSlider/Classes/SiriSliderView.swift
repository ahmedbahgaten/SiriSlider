//
//  SiriSlider.swift
//  SiriSlider
//
//  Created by Ahmed Bahgat on 07/03/2024.
//

import Foundation

import UIKit
import Combine

public class SiriSliderView: UIView {
    //MARK: - Vars
  private lazy var leadingHeadView = LeadingHeadView()
  private lazy var trailingHeadView = TrailingHeadView()
  private lazy var leadingLbl = UILabel()
  private lazy var trailingLbl = UILabel()
  private lazy var outerTrackView = UIView()
  private lazy var innerTrackView = UIView()
  private var subscriptions = Set<AnyCancellable>()
  
  private var configuration:SiriSliderConfiguration
  private var leadingHeadViewLeadingConstraint:NSLayoutConstraint?
  private var leadingHeadViewWidthAnchor:NSLayoutConstraint?
  private var leadingHeadViewHeightAnchor:NSLayoutConstraint?
  
  private var trailingHeadViewTrailingConstraint:NSLayoutConstraint?
  private var trailingHeadViewWidthAnchor:NSLayoutConstraint?
  private var trailingHeadViewHeightAnchor:NSLayoutConstraint?
  
  private var leadingLabelAnimation: UIViewPropertyAnimator?
  private var trailingLabelAnimation: UIViewPropertyAnimator?
  
  public var fromValue:Double {
    getLeadingHeadReading()
  }
  
  public var toValue:Double {
    getTrailingHeadReading()
  }
    //MARK: - Init
  public init(configuration:SiriSliderConfiguration = SiriSliderConfiguration()) {
    self.configuration = configuration
    super.init(frame: .zero)
  }
  
  public required init?(coder: NSCoder) {
    self.configuration = SiriSliderConfiguration()
    super.init(coder: coder)
  }
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    leadingLbl.text = getLeadingHeadReading().description
    trailingLbl.text = getTrailingHeadReading().description
  }
  
  public override func didMoveToSuperview() {
    super.didMoveToSuperview()
  }
    //MARK: - Methods
  private func setupBinding() {
    leadingHeadView.newXValuePublisher
      .sink { [weak self] value in
        self?.leadingHeadViewLeadingConstraint?.constant = value
      }.store(in: &subscriptions)
    
    leadingHeadView.onFocusPublisher
      .sink { [weak self] onFocus in
        guard let self = self else {return}
        self.shouldShowLeadingLbl(show: onFocus)
        self.bringSubviewToFront(self.leadingHeadView)
      }.store(in: &subscriptions)
    
    trailingHeadView.newXValuePublisher
      .sink { [weak self] value in
        self?.trailingHeadViewTrailingConstraint?.constant = -value
      }.store(in: &subscriptions)
    
    trailingHeadView.onFocusPublisher
      .sink { [weak self] onFocus in
        guard let self = self else {return}
        self.shouldShowTrailingLbl(show: onFocus)
        self.bringSubviewToFront(self.trailingHeadView)
      }.store(in: &subscriptions)
  }
  
  public func setConfig(config:SiriSliderConfiguration) {
    self.configuration = config
    if self.configuration.customLeadingLabel != nil {
      leadingLbl = configuration.customLeadingLabel!
    }
    
    if self.configuration.customTrailingLabel != nil {
      trailingLbl = configuration.customTrailingLabel!
    }
    
    if self.configuration.customLeadingView != nil {
      leadingHeadView = config.customLeadingView!
    }
    
    if self.configuration.customTrailingView != nil {
      trailingHeadView = config.customTrailingView!
    }
    
    backgroundColor = config.backgroundColor
    setupOuterTrack()
    initialLeadingHeadViewSetup()
    initialTrailingHeadViewSetup()
    setupInnerTrack()
    setupBinding()
    addLeadingLabel()
    addTrailingLabel()
    configureLeadingHeadView()
    configureTrailingHeadView()
    setupTrailingLabel()
    setupLeadingLabel()
  }
  
  private func getLeadingHeadReading() -> Double {
    let minPointValue = configuration.minPointValue
    let maxPointValue = configuration.maxPointValue
    let leadingHeadWidth = leadingHeadView.frame.size.width / 2
    var position = leadingHeadView.getHeadPosition()
    let sliderFrame = frame.size.width
    if position == sliderFrame - leadingHeadWidth {
      position += leadingHeadWidth
    }else if position == leadingHeadWidth {
      position -= leadingHeadWidth
    }
    let ratio = position / sliderFrame
    return (minPointValue + (ratio * (maxPointValue - minPointValue))).rounded(.down)
  }
  
  private func getTrailingHeadReading() -> Double {
    let minPointValue = configuration.minPointValue
    let maxPointValue = configuration.maxPointValue
    var position = trailingHeadView.getHeadPosition()
    let trailingHeadWidth = trailingHeadView.frame.size.width / 2
    let sliderFrame = frame.size.width
    if position == sliderFrame - trailingHeadWidth {
      position += trailingHeadWidth
    }else if position == trailingHeadWidth {
      position -= trailingHeadWidth
    }
    let ratio = position / sliderFrame
    return (minPointValue + (ratio * (maxPointValue - minPointValue))).rounded(.down)
  }
  
  private func initialLeadingHeadViewSetup() {
    guard let superView = superview else { return }
    leadingHeadView.translatesAutoresizingMaskIntoConstraints = false
    guard !superView.subviews.contains(leadingHeadView) else { return }
    addSubview(leadingHeadView)
    guard leadingHeadView.constraints.isEmpty else { return }
    
    leadingHeadViewLeadingConstraint = leadingHeadView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
    leadingHeadViewWidthAnchor = leadingHeadView.widthAnchor.constraint(equalToConstant: configuration.headSize.width)
    leadingHeadViewHeightAnchor = leadingHeadView.heightAnchor.constraint(equalToConstant: configuration.headSize.height)
    
    leadingHeadView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
    [leadingHeadViewLeadingConstraint,leadingHeadViewHeightAnchor,leadingHeadViewWidthAnchor].forEach {$0?.isActive = true}
  }
  
  private func initialTrailingHeadViewSetup() {
    guard let superView = superview else { return }
    trailingHeadView.translatesAutoresizingMaskIntoConstraints = false
    guard !superView.subviews.contains(trailingHeadView) else { return }
    addSubview(trailingHeadView)
    guard trailingHeadView.constraints.isEmpty else { return }
    trailingHeadViewTrailingConstraint = trailingHeadView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: 0)
    trailingHeadViewWidthAnchor = trailingHeadView.widthAnchor.constraint(equalToConstant: configuration.headSize.width)
    trailingHeadViewHeightAnchor = trailingHeadView.heightAnchor.constraint(equalToConstant: configuration.headSize.height)
    
    trailingHeadView.centerYAnchor.constraint(equalTo: centerYAnchor,
                                              constant: 0).isActive = true
    [trailingHeadViewTrailingConstraint,
     trailingHeadViewWidthAnchor,
     trailingHeadViewHeightAnchor].forEach { $0?.isActive = true }
  }
  
  private func configureLeadingHeadView() {
    leadingHeadView.backgroundColor = configuration.headColor
    leadingHeadView.layer.cornerRadius = configuration.headRadius
    leadingHeadViewWidthAnchor?.constant = configuration.headSize.width
    leadingHeadViewHeightAnchor?.constant = configuration.headSize.height
    guard let startAt = configuration.startAt else { return }
    let minValue = configuration.minPointValue
    let maxValue = configuration.maxPointValue
    guard startAt < maxValue && startAt > minValue  else { return }
    let ratio = (startAt - minValue ) / (maxValue - minValue )
    let xPoint = (ratio * frame.size.width) - configuration.headSize.width / 2
    leadingHeadViewLeadingConstraint?.constant = xPoint
  }
  
  private func configureTrailingHeadView() {
    trailingHeadView.backgroundColor = configuration.headColor
    trailingHeadView.layer.cornerRadius = configuration.headRadius
    trailingHeadViewWidthAnchor?.constant = configuration.headSize.width
    trailingHeadViewHeightAnchor?.constant = configuration.headSize.height
    guard let startAt = configuration.endAt else { return }
    let minValue = configuration.minPointValue
    let maxValue = configuration.maxPointValue
    guard startAt < maxValue && startAt > minValue  else { return }
    let ratio = 1 - ((startAt - minValue ) / (maxValue - minValue ))
    let xPoint = (ratio * frame.size.width) - configuration.headSize.width / 2
    trailingHeadViewTrailingConstraint?.constant = -xPoint
  }
  
  private func addLeadingLabel() {
    guard configuration.showLabels else { return }
    guard !subviews.contains(leadingLbl) else { return }
    addSubview(leadingLbl)
    guard !configuration.alwaysShowLabels else { return }
    leadingLbl.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
    leadingLbl.alpha = 0
  }
  
  private func addTrailingLabel() {
    guard configuration.showLabels else { return }
    guard !subviews.contains(trailingLbl) else { return }
    addSubview(trailingLbl)
    guard !configuration.alwaysShowLabels else { return }
    trailingLbl.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
    trailingLbl.alpha = 0
  }
  
  private func setupLeadingLabel() {
    leadingLbl.translatesAutoresizingMaskIntoConstraints = false
    let labelOffset = configuration.labelOffset
    let labelPosition = configuration.labelPosition
    let leadingHeadViewAnchor = labelPosition == .top ? leadingHeadView.topAnchor : leadingHeadView.bottomAnchor
    let leadingLblAnchor = labelPosition == .top ? leadingLbl.bottomAnchor : leadingLbl.topAnchor
    let constant:CGFloat = labelPosition == .top ? -labelOffset : labelOffset
    leadingLblAnchor.constraint(equalTo: leadingHeadViewAnchor, constant: constant).isActive = true
    
    leadingLbl.centerXAnchor.constraint(equalTo: leadingHeadView.centerXAnchor).isActive = true
    
    leadingLbl.numberOfLines = 0
    leadingLbl.textColor = configuration.labelTextColor
    leadingLbl.font = UIFont.systemFont(ofSize: configuration.labelFontSize)
  }
  
  private func setupTrailingLabel() {
    trailingLbl.translatesAutoresizingMaskIntoConstraints = false
    let labelOffset = configuration.labelOffset
    let labelPosition = configuration.labelPosition
    let trailingHeadViewAnchor = labelPosition == .top ? trailingHeadView.topAnchor : trailingHeadView.bottomAnchor
    let trailingLblAnchor = labelPosition == .top ? trailingLbl.bottomAnchor : trailingLbl.topAnchor
    let constant:CGFloat = labelPosition == .top ? -labelOffset : labelOffset
    trailingLblAnchor.constraint(equalTo: trailingHeadViewAnchor, constant: constant).isActive = true
    
    trailingLbl.centerXAnchor.constraint(equalTo: trailingHeadView.centerXAnchor).isActive = true
    
    trailingLbl.numberOfLines = 0
    trailingLbl.textColor = configuration.labelTextColor
    trailingLbl.font = UIFont.systemFont(ofSize: configuration.labelFontSize)
  }
  
  private func shouldShowLeadingLbl(show:Bool) {
    guard !configuration.alwaysShowLabels else { return }
    let delay: Double = show ? 0 : 2
    leadingLabelAnimation?.stopAnimation(false)
    leadingLabelAnimation?.finishAnimation(at: .end)
    leadingLabelAnimation = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) { [weak self] in
      if show {
        self?.leadingLbl.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        self?.leadingLbl.alpha = 1.0
      }else {
        self?.leadingLbl.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        self?.leadingLbl.alpha = 0
      }
    }
    leadingLabelAnimation?.startAnimation(afterDelay: delay)
  }
  
  private func shouldShowTrailingLbl(show:Bool) {
    guard !configuration.alwaysShowLabels else { return }
    let delay: Double = show ? 0 : 2
    trailingLabelAnimation?.stopAnimation(false)
    trailingLabelAnimation?.finishAnimation(at: .end)
    trailingLabelAnimation = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) { [weak self] in
      if show {
        self?.trailingLbl.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        self?.trailingLbl.alpha = 1.0
      }else {
        self?.trailingLbl.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        self?.trailingLbl.alpha = 0.0
      }
    }
    trailingLabelAnimation?.startAnimation(afterDelay: delay)
  }
  
  private func setupOuterTrack() {
    outerTrackView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(outerTrackView)
    outerTrackView.backgroundColor = configuration.outerTrackColor
    outerTrackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
    outerTrackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
    outerTrackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    outerTrackView.heightAnchor.constraint(equalToConstant: configuration.outerTrackHeight).isActive = true
    outerTrackView.layer.cornerRadius = configuration.outerTrackHeight / 2
  }
  
  private func setupInnerTrack() {
    innerTrackView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(innerTrackView)
    innerTrackView.backgroundColor = configuration.innerTrackColor
    innerTrackView.leadingAnchor.constraint(equalTo: leadingHeadView.trailingAnchor, constant: 0).isActive = true
    innerTrackView.trailingAnchor.constraint(greaterThanOrEqualTo: trailingHeadView.leadingAnchor, constant: 0).isActive = true
    innerTrackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    innerTrackView.heightAnchor.constraint(equalToConstant: configuration.innerTrackHeight).isActive = true
  }
}
