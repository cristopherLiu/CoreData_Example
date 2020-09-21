//
//  LoginDialog.swift
//  CoreData_Example
//
//  Created by hjliu on 2020/9/21.
//

import UIKit

class LoginDialog: DialogVC {
  
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.text = "登入"
    label.font = UIFont.boldSystemFont(ofSize: 24.0)
    label.textColor = UIColor.bk
    label.textAlignment = NSTextAlignment.center
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var accTextField: UITextField = {
    let textField = UITextField()
    textField.backgroundColor = UIColor.w
    textField.doneAccessory = true
    textField.autocorrectionType = UITextAutocorrectionType.no //是否支援自動拼音
    textField.autocapitalizationType = UITextAutocapitalizationType.none //首字母是否大寫
    textField.keyboardType = UIKeyboardType.asciiCapable
    textField.tintColor = UIColor.pri //游標顏色
    textField.textColor = UIColor.pri
    textField.font = UIFont.systemFont(ofSize: 24.0)
    textField.attributedPlaceholder = NSAttributedString(string: "帳號",
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.pri_5])
    textField.returnKeyType = UIReturnKeyType.next //設定return key type
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }()
  
  private lazy var nameTextField: UITextField = {
    let textField = UITextField()
    textField.backgroundColor = UIColor.w
    textField.doneAccessory = true
    textField.autocorrectionType = UITextAutocorrectionType.no //是否支援自動拼音
    textField.autocapitalizationType = UITextAutocapitalizationType.none //首字母是否大寫
    textField.keyboardType = UIKeyboardType.default
    textField.tintColor = UIColor.pri //游標顏色
    textField.textColor = UIColor.pri
    textField.font = UIFont.systemFont(ofSize: 24.0)
    textField.attributedPlaceholder = NSAttributedString(string: "姓名",
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.pri_5])
    textField.textContentType = UITextContentType.username
    textField.returnKeyType = UIReturnKeyType.next //設定return key type
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }()
  
  private lazy var leftButton: UIButton = {
    let button = UIButton()
    button.setTitle("取消", for: .normal)
    button.setTitleColor(UIColor.w, for: .normal)
    button.setBackgroundImage(UIColor.bk.toImage(), for: .normal)
    button.setBackgroundImage(UIColor.bk_5.toImage(), for: .highlighted)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 24.0)
    button.addTarget(self, action: #selector(tapLeftButton), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private lazy var rightButton: UIButton = {
    let button = UIButton()
    button.setTitle("登入", for: .normal)
    button.setTitleColor(UIColor.w, for: .normal)
    button.setBackgroundImage(UIColor.pri.toImage(), for: .normal)
    button.setBackgroundImage(UIColor.pri_5.toImage(), for: .highlighted)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 24.0)
    button.addTarget(self, action: #selector(tapRightButton), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private var leftButtonEvent: (() -> Void)?
  private var rightButtonEvent: (() -> Void)?
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.initializer()
  }
  
  init(leftButtonEvent: (() -> Void)? = nil, rightButtonEvent: (() -> Void)? = nil) {
    super.init()
    self.leftButtonEvent = leftButtonEvent
    self.rightButtonEvent = rightButtonEvent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initView()
  }
  
  func initView() {
    
    contentView.backgroundColor = UIColor.gy
    
    contentView.addSubview(titleLabel)
    contentView.addSubview(accTextField)
    contentView.addSubview(nameTextField)
    contentView.addSubview(leftButton)
    contentView.addSubview(rightButton)
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
      titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
      titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32),
      
      accTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
      accTextField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
      accTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32),
      
      nameTextField.topAnchor.constraint(equalTo: accTextField.bottomAnchor, constant: 24),
      nameTextField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
      nameTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32),
      
      leftButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 48),
      leftButton.heightAnchor.constraint(equalToConstant: 72),
      leftButton.widthAnchor.constraint(equalToConstant: 200),
      leftButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      leftButton.leftAnchor.constraint(equalTo: contentView.leftAnchor),
      
      rightButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 48),
      rightButton.heightAnchor.constraint(equalToConstant: 72),
      rightButton.widthAnchor.constraint(equalToConstant: 200),
      rightButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      rightButton.leftAnchor.constraint(equalTo: leftButton.rightAnchor),
      rightButton.rightAnchor.constraint(equalTo: contentView.rightAnchor),
    ])
  }
  
  // 關閉畫面
  @objc func tapLeftButton() {
    self.hideWithAnimate(completion: self.leftButtonEvent)
  }
  
  // 關閉畫面
  @objc func tapRightButton() {
    
    let udService = UDService()
    udService.acc = self.accTextField.text
    udService.name = self.nameTextField.text
    
    self.hideWithAnimate(completion: self.rightButtonEvent)
  }
}

