//
//  SectionView.swift
//  CoreData_Example
//
//  Created by hjliu on 2020/9/18.
//

import UIKit

public class SectionView: UIView {
  
  private lazy var bgView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.bk
    view.layer.cornerRadius = 16
    view.clipsToBounds = true
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 17)
    label.textAlignment = .center
    label.textColor = UIColor.w
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    initView()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initView()
  }
  
  public func setTitle(_ text: String) {
    self.titleLabel.text = text
  }
  
  private func initView() {
    self.backgroundColor = UIColor.clear
    
    self.addSubview(bgView)
    bgView.addSubview(titleLabel)
    
    NSLayoutConstraint.activate([
      
      bgView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      bgView.heightAnchor.constraint(equalToConstant: 32),
      bgView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
      bgView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
      
      titleLabel.leftAnchor.constraint(equalTo: bgView.leftAnchor, constant: 8),
      titleLabel.rightAnchor.constraint(equalTo: bgView.rightAnchor, constant: -8),
      titleLabel.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 4),
      titleLabel.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -4),
    ])
  }
}
