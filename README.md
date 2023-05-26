# Helpers

<p align="center">
<img src="Assets/logo.png" width="15%" alt="Helpers Logo" />
<br />
</p>
Tiny convenient code pieces that I'm tired of copy-paste across all my projects. 

## Swift Stdlib Extensions and Common things I need sometimes (Helpers):
<details>
<summary>Array;</summary>
    
```swift
subscript (safe index: Int) -> Element?
func subtract(_ other: [Element]) -> [Element]
func distance(to index: Index) -> Int 
```
 
</details>

<details>
<summary>Decimal;</summary>
    
```swift
var doubleValue: Double
```
 
</details>

<details>
<summary>Double;</summary>
    
```swift
func roundToDecimals(_ decimals: Int, rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> Double
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

<details>
<summary>Something I need sometimes;</summary>

- struct DateRange;
- protocol AppDetails - provides app version and build number;
- protocol AppStoreReview - provides dialog for Rate Us;
- protocol DeviceDetails - provides device model, system version and  device locale;
- protocol ErrorLocalizedDescription;
- Formatter - easy way to format numbers;
- JsonObject - pretty typealias for [String: Any].


</details>

## Combine (HelpersCombine)
- Publisher:
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

- Future:
```swift
convenience init(asyncFunc: @escaping () async throws -> Output)
convenience init(asyncFunc: @escaping () async -> Output)
```

## In-App (HelpersIAP):
- IAPProduct model;

## [RxSwift](https://github.com/ReactiveX/RxSwift) Extensions (HelpersRxSwift):
```swift
func mapToVoid()
func filterFalse()
func filterTrue()
func invert()
func asDelayedActivity(_ delay: DispatchTimeInterval = .milliseconds(200))
func mapArray<T>(transform)
func fromAsync(_ block: { element in ... }) -> Single<Element>
```

## SwiftUI (HelpersSwiftUI):
ViewExtension:
```swift
/// Applies the given transform if the given condition evaluates to `true`
@ViewBuilder func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View
```

Modifiers:
```swift
func blink(on state: Binding<Bool>, duration: Double = 0.1)
func navigationBarColors(background: Color, tint: Color)
func onFrameChange(enabled isEnabled: Bool = true, frameHandler: @escaping (CGRect)->Void)
func cornerRadius(_ radius: CGFloat, corners: UIRectCorner)
func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void)
func rotateHandling(anchor: UnitPoint = .center)
func rotated(_ angle: Angle)
func shimmer(isActive: Bool = true, speed: Double = 0.15, angle: Angle = .init(degrees: 70), opacity: Double = 1.0)
```

Shapes:
```swift
func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) 
```

<details>
<summary>Views</summary>
    
- MailView.
    
</details>


## Installation
Helpers available via: 
- Swift Package Manager by url: [https://github.com/bigMOTOR/Helpers.git](https://github.com/bigMOTOR/Helpers.git)


## License

Helpers is available under the MIT license. See the LICENSE file for more info.
