# Helpers

<p align="center">
<img src="Assets/logo.png" width="15%" alt="Helpers Logo" />
<br />
</p>
Tiny convenient code pieces that I'm tired of copy-paste across all my projects. 

## Combine (HelpersCombine)
- PublisherExtension:
```swift
func mapToVoid()
func mapToOptional()
func flatMapLatest()
func filterFalse() 
func filterTrue() 
func invert() 
func mapArray<T>(transform)
func shareReplay(bufferSize)    // Adapted from https://www.onswiftwings.com/posts/share-replay-operator/ 
```

## In-App (HelpersIAP):
- IAPProduct model;

## Library (HelpersLibrary):
- protocol AppDetails - provides app version and build number;
- protocol AppStoreReview - provides dialog for Rate Us;
- protocol DeviceDetails - provides device model,  system version and  device locale;
- protocol ErrorLocalizedDescription;
- Formatter - easy way to format numbers;
- JsonObject - pretty typealias for [String: Any].

## [RxSwift](https://github.com/ReactiveX/RxSwift) Extensions (HelpersRxSwift):
```swift
func mapToVoid()
func filterFalse()
func filterTrue()
func invert()
func asDelayedActivity(_ delay: DispatchTimeInterval = .milliseconds(200))
func mapArray<T>(transform)
```

## Swift Stdlib Extensions (HelpersSwift):
<details>
<summary>Array;</summary>
    
```swift
subscript (safe index: Int) -> Element?
func subtract(_ other: [Element]) -> [Element]
func distance(to index: Index) -> Int 
```
 
</details>

<details>
<summary>Date;</summary>
    
- work with unixMilliseconds;
- date components;
- beginning/end of date components;
- adding date components;
- comparison.
    
</details>

<details>
<summary>UserDefaults;</summary>
    
- provides getter and setter for Codable values.
    
</details>

## SwiftUI (HelpersSwiftUI):
Modifiers:
```swift
func navigationBarColors(background: Color, tint: Color)
func onFrameChange(enabled isEnabled: Bool = true, frameHandler: @escaping (CGRect)->())
func shimmer(isActive: Bool = true, speed: Double = 0.15, angle: Angle = .init(degrees: 70), opacity: Double = 1.0)
func cornerRadius(_ radius: CGFloat, corners: UIRectCorner)
func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void)
func rotateHandling(anchor: UnitPoint = .center)
func rotated(_ angle: Angle)
func blink(on state: Binding<Bool>, duration: Double = 0.1)
```

<details>
<summary>Views</summary>
    
- MailView.
    
</details>

## [The Composable Architecture (TCA)](https://github.com/pointfreeco/swift-composable-architecture) Helpers (HelpersTCA):
- Lifecycle Reducer ([problem statement](https://forums.swift.org/t/ifletstore-and-effect-cancellation-on-view-disappear/38272/7));
- Equatable VoidResult type;
- Equatable WrappedError type.

Many thanks to [Misha Markin](mailto:shire8bit@gmail.com) at this part. 

## Rx and TCA Wrappers for [RevenueCat Subscription Platform](https://www.revenuecat.com) (RevenuecatRx or RevenuecatComposable)

## Installation
Helpers available via: 
- Swift Package Manager by url: [https://github.com/bigMOTOR/Helpers.git](https://github.com/bigMOTOR/Helpers.git)


## License

Helpers is available under the MIT license. See the LICENSE file for more info.
