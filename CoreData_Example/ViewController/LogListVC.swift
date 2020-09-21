//
//  Page1VC.swift
//  CoreData_Example
//
//  Created by hjliu on 2020/9/18.
//

import UIKit

class RootVC: UIViewController {
  
  private lazy var loginButton: UIButton = {
    let button = UIButton()
    button.setTitleColor(UIColor.w, for: .normal)
    button.setTitleColor(UIColor.w_5, for: .highlighted)
    button.setTitleColor(UIColor.w_5, for: .disabled)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
    button.addTarget(self, action: #selector(tapInOut), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private lazy var addButton: UIBarButtonItem = {
    let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addMessage))
    button.tintColor = UIColor.w
    return button
  }()
  
  private lazy var tableView: UITableView = {
    let view = UITableView()
    view.backgroundColor = UIColor.clear
    view.delegate = self
    view.dataSource = self
    view.register(TextCell.self, forCellReuseIdentifier: TextCell.cellIdentifier())
    view.separatorStyle = UITableViewCell.SeparatorStyle.none
    view.rowHeight = UITableView.automaticDimension
    view.estimatedRowHeight = 44
    view.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(refreshControl)
    return view
  }()
  
  lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
    return refreshControl
  }()
  
  private let dbService = DBService()
  private let udService = UDService()
  
  private var tableData = [SectionViewModel]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    // 觀察鍵盤事件
//    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: nil) { [weak self] (noti) in
//      self?.keyboardNotification(notification: noti)
//    }
    loadData()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }
  
  func initView() {
    
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: loginButton)
    self.navigationItem.rightBarButtonItem = addButton
    
    setLetButtonTitle()
    
    view.backgroundColor = UIColor.pri
    view.addSubview(tableView)
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
      tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
    ])
  }
  
  @objc func loadData() {
    
    var sectionTable = [String: [TextCellViewModel]]()
    
    self.dbService.allMsgs.forEach({ data in
      
      let model = buildCellModel(data)
      let groupingKey = sectionGroupingKey(model)
      
      if var rows = sectionTable[groupingKey] {
        rows.append(model)
        sectionTable[groupingKey] = rows
      } else {
        sectionTable[groupingKey] = [model]
      }
    })
    
    self.tableData = converToSectionViewModel(sectionTable)
    self.tableView.reloadData()
  }
  
  @objc func tapInOut() {
    
    if udService.isLogin {
      // 跳出是否登出dialog
      let dialog = ConfirmDialog(title: "是否確定登出！", leftButtonTitle: "取消", rightButtonTitle: "確定", rightButtonEvent: {
        self.udService.clear()
        self.setLetButtonTitle()
      })
      self.present(dialog, animated: true, completion: nil)
    } else {
      // 跳出登入dialog
      let dialog = LoginDialog(leftButtonEvent: nil, rightButtonEvent: {
        self.setLetButtonTitle()
      })
      self.present(dialog, animated: true, completion: nil)
    }
  }
  
  private func setLetButtonTitle() {
    
    if let name = udService.name {
      loginButton.setTitle(name, for: .normal)
    } else {
      loginButton.setTitle("登入", for: .normal)
    }
  }
  
  @objc func addMessage() {
    let dialog = MessageDialog(topHeight: self.topbarHeight)
    dialog.addTarget(sendEvent: { text in
      self.toAdd(text)
    })
    self.present(dialog, animated: true, completion: nil)
  }
  
  private func toAdd(_ text: String) {
    
    guard let user = self.udService.name else {return}
    self.dbService.addMessage(user: user, text: text)
    self.loadData()
  }
}

extension RootVC {
  
  private func buildCellModel(_ msg: Message) -> TextCellViewModel {
    guard let name = msg.user, let text = msg.text, let time = msg.time else {
      return TextCellViewModel(name: "", text: "", time: Date())
    }
    return TextCellViewModel(name: name, text: text, time: time)
  }
  
  private func converToSectionViewModel(_ sectionTable: [String: [TextCellViewModel]]) -> [SectionViewModel] {
    // Sort the array base on the date
    let sortedGroupingKey = sectionTable.keys.sorted(by: dateStringDescComparator())
    
    return sortedGroupingKey.map {
      let rowViewModels = sectionTable[$0]!
      return SectionViewModel(rowViewModels: rowViewModels, headerTitle: $0)
    }
  }
  
  private func sectionGroupingKey(_ model: TextCellViewModel) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.string(from: model.time)
  }
  
  private func dateStringDescComparator() -> ((String, String) -> Bool) {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return { (d1Str, d2Str) -> Bool in
      if let d1 = formatter.date(from: d1Str), let d2 = formatter.date(from: d2Str) {
        return d1 > d2
      } else {
        return false
      }
    }
  }
}

extension RootVC: UITableViewDataSource, UITableViewDelegate {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return tableData.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let sectionViewModel = tableData[section]
    return sectionViewModel.rowViewModels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let sectionViewModel = tableData[indexPath.section]
    let rowViewModel = sectionViewModel.rowViewModels[indexPath.row]
    
    let cell = tableView.dequeueReusableCell(withIdentifier: TextCell.cellIdentifier(), for: indexPath) as! TextCell
    cell.setup(viewModel: rowViewModel)
    cell.layoutIfNeeded()
    return cell
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = SectionView()
    let sectionViewModel = tableData[section]
    view.setTitle(sectionViewModel.headerTitle)
    return view
  }
}

//extension RootVC {
//
//  @objc func keyboardNotification(notification: Notification) {
//
//    guard isViewLoaded, let window = view.window, let userInfo = notification.userInfo else {
//      return
//    }
//    //動畫時間
//    guard let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {
//      return
//    }
//    //動畫曲線
//    guard let rawAnimationCurve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {
//      return
//    }
//
//    guard let endFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
//      return
//    }
//
//    let endFrameInWindow = window.convert(endFrame, from: nil)
//    let endFrameInView = view.convert(endFrameInWindow, from: nil)
//    let endFrameIntersection = view.bounds.intersection(endFrameInView)
//
//    let keyboardHeight = view.bounds.maxY - endFrameIntersection.minY // 鍵盤高
//    let options = UIView.AnimationOptions(rawValue: rawAnimationCurve << 16)
//
//    guard let activeTextField = activeTextField else {return}
//    let textFieldFrame = activeTextField.convert(activeTextField.frame, to: self.contentView)
//    //    let textFieldMinY = textFieldFrame.minY
//    let textFieldMaxY = textFieldFrame.maxY
//    let keyboardMinY = endFrameIntersection.minY
//
//    // 移動距離
//    let moveConstant = keyboardHeight == 0 ? 0 : min(-(textFieldMaxY - keyboardMinY), 0)
//
//    UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
//
//      self.viewCenterY.constant = moveConstant
//      self.view.layoutIfNeeded()
//    })
//  }
//}
