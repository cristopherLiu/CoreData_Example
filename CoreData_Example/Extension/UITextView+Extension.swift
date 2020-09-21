//
//  MyTextView.swift
//  HealthReport
//
//  Created by 劉紘任 on 2020/3/18.
//  Copyright © 2020 劉紘任. All rights reserved.
//

import UIKit

extension UITextView {
  
  // 行數
  var numberOfLines:Int{
    if let _ = self.font?.lineHeight{
      let newSize = self.contentSize.height - self.textContainerInset.top - self.textContainerInset.bottom
      let n = newSize / self.font!.lineHeight
      //            let n = textContainer.size.height / self.font!.lineHeight
      return Int(round(n))
    }
    return 0
  }
}

extension UITextView {
  
  @IBInspectable var doneAccessory: Bool{
    get{
      return self.doneAccessory
    }
    set (hasDone) {
      if hasDone{
        addDoneButtonOnKeyboard()
      }
    }
  }
  
  func addDoneButtonOnKeyboard() {
    
    let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
    doneToolbar.barStyle = .default
    
    let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let done: UIBarButtonItem = UIBarButtonItem(title: "完成", style: .done, target: self, action: #selector(self.doneButtonAction))
    done.tintColor = UIColor.bk
    
    if #available(iOS 13.0, *) {
      if UITraitCollection.current.userInterfaceStyle == .dark {
        done.tintColor = UIColor.w
      }
    }
    
    let items = [flexSpace, done]
    doneToolbar.items = items
    doneToolbar.sizeToFit()
    
    self.inputAccessoryView = doneToolbar
  }
  
  @objc func doneButtonAction() {
    self.resignFirstResponder()
  }
}

//extension UITextView: UITextViewDelegate {
//
//  /// Resize the placeholder when the UITextView bounds change
//  override open var bounds: CGRect {
//    didSet {
//      self.resizePlaceholder()
//    }
//  }
//
//  /// The UITextView placeholder text
//  public var placeholder: String? {
//    get {
//      var placeholderText: String?
//
//      if let placeholderLabel = self.viewWithTag(100) as? UILabel {
//        placeholderText = placeholderLabel.text
//      }
//
//      return placeholderText
//    }
//    set {
//      if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
//        placeholderLabel.text = newValue
//        placeholderLabel.sizeToFit()
//      } else {
//        self.addPlaceholder(newValue!)
//      }
//    }
//  }
//
//  public var placeholderColor: UIColor? {
//    get {
//      var color: UIColor?
//      if let placeholderLabel = self.viewWithTag(100) as? UILabel {
//        color = placeholderLabel.textColor
//      }
//      return color
//    }
//    set {
//      if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
//        placeholderLabel.textColor = newValue
//      }
//    }
//  }
//
//  /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
//  ///
//  /// - Parameter textView: The UITextView that got updated
//  public func textViewDidChange(_ textView: UITextView) {
//    if let placeholderLabel = self.viewWithTag(100) as? UILabel {
//      placeholderLabel.isHidden = !self.text.isEmpty
//    }
//  }
//
//  /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
//  private func resizePlaceholder() {
//    if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
//      let labelX = self.textContainer.lineFragmentPadding
//      let labelY = self.textContainerInset.top
////      let labelWidth = self.frame.width - (labelX * 2)
//      let labelWidth = placeholderLabel.frame.width
//      let labelHeight = placeholderLabel.frame.height
//
//      print(self.textContainerInset)
//      print(self.frame.width)
//
//      placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
//    }
//  }
//
//  /// Adds a placeholder UILabel to this UITextView
//  private func addPlaceholder(_ placeholderText: String) {
//    let placeholderLabel = UILabel()
//    placeholderLabel.font = self.font
//    placeholderLabel.textColor = placeholderColor ?? UIColor.lightGray
//    placeholderLabel.tag = 100
//    placeholderLabel.isHidden = !self.text.isEmpty
//
//    placeholderLabel.text = placeholderText
//    placeholderLabel.sizeToFit()
//
//    self.addSubview(placeholderLabel)
//    self.resizePlaceholder()
//    self.delegate = self
//  }
//
//}
