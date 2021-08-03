//
//  MailView.swift
//  
//
//  Created by Nikolay Fiantsev on 02.08.2021.
//

import SwiftUI
import MessageUI
import HelpersLibrary

public struct MailView: UIViewControllerRepresentable, AppDetails, DeviceDetails {
  
  @Environment(\.presentationMode) var presentation
  @Binding var result: Result<MFMailComposeResult, Error>?
  private let _recipient: String
  private let _subject: String
  
  public init(result: Binding<Result<MFMailComposeResult, Error>?>, recipient: String, subject: String) {
    self._result = result
    self._recipient = recipient
    self._subject = subject
  }
  
  public func makeCoordinator() -> Coordinator {
    return Coordinator(presentation: presentation, result: $result)
  }
  
  public func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
    let mailCompose = MFMailComposeViewController()
    mailCompose.setToRecipients([_recipient])
    mailCompose.setMessageBody("\n\nmodel: \(deviceModel) \nOS version: \(systemVersion) \nApp version: \(appVersion) \nCountry: \(deviceLocale)", isHTML: false)
    mailCompose.setSubject(_subject)
    mailCompose.mailComposeDelegate = context.coordinator
    return mailCompose
  }
  
  public func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailView>) {
  }
  
}

extension UIViewController: MFMailComposeViewControllerDelegate {
  public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    controller.dismiss(animated: true)
  }
}

extension MailView {
  
  final public class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
    
    @Binding private var _presentation: PresentationMode
    @Binding private var _result: Result<MFMailComposeResult, Error>?
    
    init(presentation: Binding<PresentationMode>, result: Binding<Result<MFMailComposeResult, Error>?>) {
      __presentation = presentation
      __result = result
    }
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
      
      defer {
        $_presentation.wrappedValue.dismiss()
      }
      
      switch error {
      case .none:
        self._result = .success(result)
      case .some(let err):
        self._result = .failure(err)
      }
      
    }
  }
  
}

