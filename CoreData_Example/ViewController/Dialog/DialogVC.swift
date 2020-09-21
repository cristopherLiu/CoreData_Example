//
//  DialogVC.swift
//  CoreData_Example
//
//  Created by hjliu on 2020/9/21.
//

import Foundation
import UIKit

class DialogVC: UIViewController {
  
  // 底
  private lazy var ContentView: UIView = {
    let view = UIView()
    view.layer.cornerRadius = 16
    view.clipsToBounds = true
    view.backgroundColor = UIColor.w
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  var contentView: UIView {
    return ContentView
  }
  
  lazy var viewCenterY: NSLayoutConstraint = {
    return ContentView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
  }()
  
  private var screenSize: CGRect {
    return UIScreen.main.bounds
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.initializer()
  }
  
  init() {
    super.init(nibName: nil, bundle: nil)
    self.initializer()
  }
  
  func initializer() {
    self.providesPresentationContextTransitionStyle = true
    self.definesPresentationContext = true
    self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
    self.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    showWithAnimate()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    view.layoutIfNeeded()
  }
  
  private func setupView() {
    
    self.view.backgroundColor = UIColor.bg_8
    
    view.addSubview(ContentView)
    
    NSLayoutConstraint.activate([
      viewCenterY,
      ContentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    ])
  }
  
  private func showWithAnimate() {
    
    ContentView.alpha = 0
    self.ContentView.frame.origin.y = self.ContentView.frame.origin.y + 50
    
    UIView.animate(withDuration: 0.4, animations: { () -> Void in
      self.ContentView.alpha = 1.0
      self.ContentView.frame.origin.y = self.ContentView.frame.origin.y - 50
    })
  }
  
  func hideWithAnimate(completion: (() -> Void)? = nil) {
    
    ContentView.alpha = 1.0
    
    UIView.animate(withDuration: 0.4, animations: {
      
      self.ContentView.alpha = 0
      self.ContentView.frame.origin.y = self.ContentView.frame.origin.y + 50
    }, completion: { isSuccess in
      self.dismiss(animated: true, completion: completion)
    })
  }
}
