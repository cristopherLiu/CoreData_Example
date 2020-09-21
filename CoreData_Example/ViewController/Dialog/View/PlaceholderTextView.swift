//
//  PlaceholderTextView.swift
//  CoreData_Example
//
//  Created by hjliu on 2020/9/18.
//

import UIKit

class PlaceholderTextView: UITextView {
  
  var placeholderText: String = ""{
    didSet{
      placeholderLabel.text = placeholderText
    }
  }
  
  override var text:String?{
    didSet{
      self.textDidChange()
    }
  }
  
  override var isEditable: Bool{
    didSet{
      //如果允許編輯
      if isEditable == true{
        self.backgroundColor = UIColor.w
      }else{
        self.backgroundColor = UIColor.gy
        placeholderText = ""
      }
    }
  }
  
  var textChangeEvent:((Int)->())?
  
  private var placeholderColor = UIColor.bk_5
  
  private lazy var placeholderLabel:UILabel = {
    let placeholderLabel = UILabel()
    placeholderLabel.font = UIFont.systemFont(ofSize: tipFontSize)
    placeholderLabel.textColor = placeholderColor
    placeholderLabel.textAlignment = NSTextAlignment.left
    placeholderLabel.text = placeholderText
    placeholderLabel.numberOfLines = 1
    placeholderLabel.backgroundColor = UIColor.clear
    placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
    return placeholderLabel
  }()
  
  private var tipFontSize: CGFloat = 14
  
  override init(frame: CGRect, textContainer: NSTextContainer?){
    super.init(frame: frame, textContainer: textContainer)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  func commonInit() {
    NotificationCenter.default.addObserver(self, selector: #selector(textDidChange),name: UITextView.textDidChangeNotification, object: nil)
    addSubview(placeholderLabel)
    self.font = UIFont.systemFont(ofSize: tipFontSize)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  override func updateConstraints() {
    super.updateConstraints()
    
    let viewsDict = [
      "super" : self,
      "placeholderLabel":placeholderLabel,
    ] as [String : Any]
    
    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-4-[placeholderLabel]", options: [], metrics: nil, views: viewsDict))
    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[super]-(<=0)-[placeholderLabel]", options: NSLayoutConstraint.FormatOptions.alignAllCenterY, metrics: nil, views: viewsDict))
  }
  
  @objc func textDidChange() {
    
    if let text = text{
      textChangeEvent?(text.count)
    }
    
    if self.placeholderText == "" {
      return
    }
    
    if self.text == "" || self.text == nil {
      self.placeholderLabel.sizeToFit()
      
      self.bringSubviewToFront(self.placeholderLabel)
      self.placeholderLabel.alpha = 1.0
    } else {
      self.sendSubviewToBack(self.placeholderLabel)
      self.placeholderLabel.alpha = 0.0
    }
  }
}
