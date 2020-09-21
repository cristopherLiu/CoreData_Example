//
//  ConfirmDialog.swift
//  CoreData_Example
//
//  Created by hjliu on 2020/9/21.
//

import UIKit

class ConfirmDialog: DialogVC {
  
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 24.0)
    label.textColor = UIColor.bk
    label.textAlignment = NSTextAlignment.center
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var subTitleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 24.0)
    label.textColor = UIColor.bk
    label.textAlignment = NSTextAlignment.center
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var leftButton: UIButton = {
    let button = UIButton()
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
  
  private lazy var subTitleLabelTop: NSLayoutConstraint = {
    return subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0)
  }()
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.initializer()
  }
  
  init(
    title: String,
    subTitle: String? = nil,
    leftButtonTitle: String, rightButtonTitle: String,
    leftButtonColor: UIColor = UIColor.bk, rightButtonColor: UIColor = UIColor.pri,
    leftButtonEvent: (() -> Void)? = nil, rightButtonEvent: (() -> Void)? = nil) {
    super.init()
    
    self.titleLabel.text = title
    self.subTitleLabel.text = subTitle
    
    self.leftButton.setTitle(leftButtonTitle, for: .normal)
    self.leftButton.setBackgroundImage(leftButtonColor.toImage(), for: .normal)
    self.leftButton.setBackgroundImage(leftButtonColor.withAlphaComponent(0.5).toImage(), for: .highlighted)
    
    self.rightButton.setTitle(rightButtonTitle, for: .normal)
    self.rightButton.setBackgroundImage(rightButtonColor.toImage(), for: .normal)
    self.rightButton.setBackgroundImage(rightButtonColor.withAlphaComponent(0.5).toImage(), for: .highlighted)
    
    self.leftButtonEvent = leftButtonEvent
    self.rightButtonEvent = rightButtonEvent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initView()
  }
  
  func initView() {
    
    contentView.addSubview(titleLabel)
    contentView.addSubview(subTitleLabel)
    contentView.addSubview(leftButton)
    contentView.addSubview(rightButton)
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 48),
      titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
      titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32),
      
      subTitleLabelTop,
      subTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
      subTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32),
      
      leftButton.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 48),
      leftButton.heightAnchor.constraint(equalToConstant: 72),
      leftButton.widthAnchor.constraint(equalToConstant: 200),
      leftButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      leftButton.leftAnchor.constraint(equalTo: contentView.leftAnchor),
      
      rightButton.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 48),
      rightButton.heightAnchor.constraint(equalToConstant: 72),
      rightButton.widthAnchor.constraint(equalToConstant: 200),
      rightButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      rightButton.leftAnchor.constraint(equalTo: leftButton.rightAnchor),
      rightButton.rightAnchor.constraint(equalTo: contentView.rightAnchor),
    ])
    
    if let _ = subTitleLabel.text {
      subTitleLabelTop.constant = 8
    } else {
      subTitleLabelTop.constant = 0
    }
  }
  
  // 關閉畫面
  @objc func tapLeftButton() {
    self.hideWithAnimate(completion: self.leftButtonEvent)
  }
  
  // 關閉畫面
  @objc func tapRightButton() {
    self.hideWithAnimate(completion: self.rightButtonEvent)
  }
}

