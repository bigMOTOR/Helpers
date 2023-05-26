//
//  DeviceDetails.swift
//  
//
//  Created by Nikolay Fiantsev on 30.07.2021.
//

#if os(iOS)
import Foundation
import UIKit

public protocol DeviceDetails {}

public extension DeviceDetails {
  var deviceModel: String {
    var sysinfo = utsname()
    uname(&sysinfo)
    // swiftlint:disable force_unwrapping
    return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    // swiftlint:enable force_unwrapping
  }
  
  var deviceLocale: String {
    return Locale.preferredLanguages.first ?? .naString
  }
  
  var device: String {
    return deviceModel + systemVersion
  }
  
  var systemVersion: String {
    return UIDevice.current.systemVersion
  }
}
#endif
