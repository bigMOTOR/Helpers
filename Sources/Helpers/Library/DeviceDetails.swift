//
//  DeviceDetails.swift
//  
//
//  Created by Nikolay Fiantsev on 30.07.2021.
//

import Foundation

public protocol DeviceDetails {}

public extension DeviceDetails {
  
  var deviceModel: String {
    var sysinfo = utsname()
    uname(&sysinfo)
    return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
  }
  
  var deviceLocale: String {
    return Locale.preferredLanguages.first ?? .naString
  }
}


#if canImport(UIDevice)
import UIKit

extension DeviceDetails {
  var device: String {
    return deviceModel + systemVersion
  }
  
  var systemVersion: String {
    return UIDevice.current.systemVersion
  }
}
#endif
