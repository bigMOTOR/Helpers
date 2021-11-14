//
//  DeviceDetails.swift
//  
//
//  Created by Nikolay Fiantsev on 30.07.2021.
//

import UIKit

public protocol DeviceDetails {}

public extension DeviceDetails {
  
  var device: String {
    return deviceModel + " " + systemVersion
  }
  
  var deviceModel: String {
    var sysinfo = utsname()
    uname(&sysinfo)
    return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
  }
  
  var systemVersion: String {
    return UIDevice.current.systemVersion
  }
  
  var deviceLocale: String {
    return Locale.preferredLanguages.first ?? .naString
  }
}

