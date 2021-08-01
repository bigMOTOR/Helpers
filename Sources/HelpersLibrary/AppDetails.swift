//
//  AppDetails.swift
//  
//
//  Created by Nikolay Fiantsev on 30.07.2021.
//

import Foundation
import HelpersSwift

public protocol AppDetails {}

public extension AppDetails {
  var appVersion: String {
    return version + "-" + buildNumber
  }
}

private extension AppDetails {
  var version: String {
    return (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? .naString
  }
  
  var buildNumber: String {
    return (Bundle.main.infoDictionary?["CFBundleVersion"] as? String) ?? .naString
  }
}
