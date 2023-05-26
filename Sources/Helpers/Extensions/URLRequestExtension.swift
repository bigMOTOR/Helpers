//
//  URLRequestExtension.swift
//  
//
//  Created by Nikolay Fiantsev on 30.07.2021.
//

import Foundation

public extension URLRequest {
  func cURL(pretty: Bool = false) -> String {
    let newLine = pretty ? "\\\n" : ""
    let method = (pretty ? "--request " : "-X ") + "\(self.httpMethod ?? "GET") \(newLine)"
    let url: String = (pretty ? "--url " : "") + "\'\(self.url?.absoluteString ?? "")\' \(newLine)"
    
    var cURL = "curl "
    var header = ""
    var data: String = ""
    
    if let httpHeaders = self.allHTTPHeaderFields, !httpHeaders.keys.isEmpty {
      for (key, value) in httpHeaders {
        header += (pretty ? "--header " : "-H ") + "\'\(key): \(value)\' \(newLine)"
      }
    }
    
    if let bodyData = self.httpBody, let bodyString = String(data: bodyData, encoding: .utf8), !bodyString.isEmpty {
      data = "--data '\(bodyString)'"
    }
    
    cURL += method + url + header + data
    
    return cURL
  }
}
