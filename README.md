# SiriSlider

[![Version](https://img.shields.io/cocoapods/v/SiriSlider.svg?style=flat)](https://cocoapods.org/pods/SiriSlider)
[![License](https://img.shields.io/cocoapods/l/SiriSlider.svg?style=flat)](https://cocoapods.org/pods/SiriSlider)
[![Platform](https://img.shields.io/cocoapods/p/SiriSlider.svg?style=flat)](https://cocoapods.org/pods/SiriSlider)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Features
- [x] Dual thumbs control
- [x] Highly customizable
- [x] RTL Support

## Requirements
iOS 13+

## Usage
- Place a UIView in your screen then go to the identity inspector and set the custom class to be **SiriSliderView**
- Go to your ViewController where the slider outlet exists and configure the slider appearance using SiriSliderConfiguration class.

Check the following example.
```swift
  private func config() {
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
    siriSliderView.setConfig(config: sliderConfig)
  }
```
<img src="https://github.com/ahmedbahgaten/SiriSlider/blob/main/Example.png" alt="Alt text" width="250" height="500">

To provide your custom thumb view you can do the following
- If you want to provide a custom left thumb view, you have to create a class that inherits from LeadingHeadView class, then you can provide your custom appearance of custom view and then set the sliderConfig.customLeadingView to your custom class as follow
```swift
    sliderConfig.customLeadingView = MyCustomLeftThumbView()
```
- If you want to provide a custom right thumb view, you have to create a class that inhertis from TrailingHeadView class, then you can provide your custom appearance for this custom view and then set the sliderConfig.customTrailingView to your custom class as follow
```swift
    sliderConfig.customTrailingView = MyCustomLRightThumbView()
```

## Installation

SiriSlider is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SiriSlider'
```

## Author

Ahmed Bahgat ahmedbahgatnabih@gmail.com

## License

SiriSlider is available under the MIT license. See the LICENSE file for more info.
