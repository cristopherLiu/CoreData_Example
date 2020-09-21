//
//  MessageDialog.swift
//  CoreData_Example
//
//  Created by hjliu on 2020/9/21.
//

import UIKit

class MessageDialog: UIViewController, UITextViewDelegate {
  
  // 底
  private lazy var contentView: UIView = {
    let view = UIView()
    view.layer.cornerRadius = 16
    view.clipsToBounds = true
    view.backgroundColor = UIColor.w
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  /// UI
  private lazy var textView: PlaceholderTextView = {
    
    let view = PlaceholderTextView()
    //text欄位
    view.placeholderText = "請輸入回覆內容"
    view.backgroundColor = UIColor.w
    //邊框
    view.layer.borderWidth = 0.25
    view.layer.borderColor = UIColor.bk.cgColor
    view.layer.cornerRadius = 4
    //文字
    view.textAlignment = NSTextAlignment.left
    view.font = UIFont.systemFont(ofSize: 26)
    view.textColor = UIColor.bk
    //        textView.textContainerInset = UIEdgeInsetsZero
    view.textContainerInset = UIEdgeInsets(top: 3, left: 0, bottom: 3, right: 0)
    
    view.translatesAutoresizingMaskIntoConstraints = false
    view.delegate = self
    return view
  }()
  
  private lazy var sendButton:UIButton = {
    let btn = UIButton()
    btn.isEnabled = false
    btn.setTitle("送出", for: .normal)
    btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    btn.layer.cornerRadius = 4
    btn.clipsToBounds = true
    
    btn.setTitleColor(UIColor.w, for: .normal)
    
    btn.setBackgroundImage(UIColor.pri.toImage(), for: .normal)
    btn.setBackgroundImage(UIColor.pri_5.toImage(), for: .highlighted)
    btn.setBackgroundImage(UIColor.pri_3.toImage(), for: .disabled)
    
    btn.addTarget(self, action: #selector(doSend), for: UIControl.Event.touchUpInside)
    btn.translatesAutoresizingMaskIntoConstraints = false
    return btn
  }()
  
  /// EVENT
  fileprivate var sendEvent:((String)->())? //按鈕事件
  
  //textView layout規則
  lazy var textViewH: NSLayoutConstraint = {
    return textView.heightAnchor.constraint(equalToConstant: baseLineHeight)
  }()
  
  /// SETTING
  var topHeight: CGFloat = 0
  var baseLineHeight:CGFloat = 48
  var maxRowCount = 3 //text Max Row
  
  //是否可使用text
  var textEnable:Bool{
    set{
      self.textView.isEditable = newValue
    }
    get{
      return self.textView.isEditable
    }
  }
  
  ///DATA
  private var text:String? {
    get{
      return textView.text
    }
  }
  
  //註冊事件
  func addTarget(sendEvent:((String)->())?){
    self.sendEvent = sendEvent
  }
  
  private var screenSize: CGRect {
    return UIScreen.main.bounds
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.initializer()
  }
  
  init(topHeight: CGFloat) {
    super.init(nibName: nil, bundle: nil)
    self.initializer()
    self.topHeight = topHeight
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
    textView.becomeFirstResponder()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    view.layoutIfNeeded()
  }
  
  private func setupView() {
    
    let gesture = UITapGestureRecognizer(target: self, action: #selector(toLeave))
    view.addGestureRecognizer(gesture)
    
    self.view.backgroundColor = UIColor.bg_5
    
    view.addSubview(contentView)
    contentView.addSubview(textView)
    contentView.addSubview(sendButton)
    
    NSLayoutConstraint.activate([
      contentView.topAnchor.constraint(equalTo: view.topAnchor, constant: self.topHeight),
      contentView.leftAnchor.constraint(equalTo: view.leftAnchor),
      contentView.rightAnchor.constraint(equalTo: view.rightAnchor),
      
      textView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
      textView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
      textViewH,
      
      sendButton.leftAnchor.constraint(equalTo: textView.rightAnchor, constant: 8),
      sendButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
      sendButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
      sendButton.widthAnchor.constraint(equalToConstant: 64),
      sendButton.heightAnchor.constraint(equalToConstant: baseLineHeight),
    ])
  }
  
  private func showWithAnimate() {
    
    contentView.alpha = 0
    
//    self.contentView.frame.origin.y = self.contentView.frame.origin.y + 50
    
    UIView.animate(withDuration: 0.4, animations: { () -> Void in
      self.contentView.alpha = 1.0
//      self.contentView.frame.origin.y = self.contentView.frame.origin.y - 50
    })
  }
  
  func hideWithAnimate(completion: (() -> Void)? = nil) {
    
    contentView.alpha = 1.0
    
    UIView.animate(withDuration: 0.4, animations: {
      
      self.contentView.alpha = 0
//      self.contentView.frame.origin.y = self.contentView.frame.origin.y + 50
    }, completion: { isSuccess in
      self.dismiss(animated: true, completion: completion)
    })
  }
  
  //按下按鈕事件
  @objc func doSend(){
    sendEvent?(text ?? "") //送出輸入的字串
    toLeave()
  }
  
  @objc func toLeave() {
    textView.resignFirstResponder()
    hideWithAnimate(completion: {
      self.textView.text = nil //清空
      self.updateTextViewSize()
      self.isSendEnable()
    })
  }
  
  //變更text 調整view size
  func textViewDidChange(_ textView: UITextView){
    updateTextViewSize()
    isSendEnable()
  }
  
  private func isSendEnable(){
    
    //有輸入文字 才可以送出
    if let text = text , text.isEmpty == false{
      sendButton.isEnabled = true
    } else {
      sendButton.isEnabled = false
    }
  }
  
  private func updateTextViewSize(){
    
    //沒超過最大行數
    if textView.numberOfLines <= maxRowCount{
      textViewH.constant = self.textView.sizeThatFits(self.textView.frame.size).height //textView layout規則
      textView.scrollRectToVisible(CGRect(x: 0,y: 0,width: 1,height: 1), animated: false)
    }else{
      //滾動到textView 文字可視範圍
      let range = textView.selectedRange
      textView.scrollRangeToVisible(range)
    }
    
    if (textViewH.constant < baseLineHeight) || (textView.text == "") {
      textViewH.constant = baseLineHeight
    }
  }
}
