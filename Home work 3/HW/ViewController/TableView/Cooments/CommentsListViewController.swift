//
//  CommentsListViewController.swift
//  HW
//
//  Created by Денис Шишкин on 11.04.2022.
//

import UIKit

final class CommentsListViewController: UIViewController {
  
  @IBOutlet weak var commentsTextView: UITextView!
  @IBOutlet weak var tableView: UITableView!
  @IBAction func addCommentsButton(_ sender: Any) {
    photoItem.comments.append(PhotoItem.Comment(author: "Denis",
                                                text: commentsTextView.text))
    commentsTextView.text = ""
    tableView.reloadData()
    commentsTextView.endEditing(true)
  }
  
  var photoItem: PhotoItem
  let indexPhotoItemInArray: Int
  let delegate: canUpdatePhotoItemInArray
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(photoItem: PhotoItem,
       indexPhotoItemInArray: Int,
       delegate: canUpdatePhotoItemInArray) {
    self.photoItem = photoItem
    self.indexPhotoItemInArray = indexPhotoItemInArray
    self.delegate = delegate
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    addKeyboardNotifications()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    delegate.updatePhotoItemInArray(photoItem: photoItem,
                                    index: indexPhotoItemInArray)
  }
  
  private func setupTableView() {
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.tableFooterView = UIView()
    tableView.allowsSelection = false
    
    let nib = UINib(nibName: CommentsCellView.reuseIdentifier, bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: CommentsCellView.reuseIdentifier)
    
    navigationItem.title = photoItem.description
    
    commentsTextView.layer.borderWidth = 0.3;
    commentsTextView.layer.borderColor = UIColor.blue.cgColor;
    commentsTextView.layer.cornerRadius = 5;
    commentsTextView.clipsToBounds = true;
    commentsTextView.text = ""
    
  }
  
}

// MARK: -  UITableViewDelegate, UITableViewDataSource
extension CommentsListViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return photoItem.comments.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let comment = photoItem.comments[indexPath.row]
    
    let cell = tableView.dequeueReusableCell(withIdentifier: CommentsCellView.reuseIdentifier, for: indexPath) as! CommentsCellView
    cell.comment = comment
    cell.configure()
    
    return cell
  }
  
}

// MARK: -  Поддержка клавиатуры

extension CommentsListViewController {
  
  func addKeyboardNotifications() {
    // Отображение клавиатуры
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    
    // Скрываем клавиатуру
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  @objc func keyboardWillShow(notification: NSNotification) {
    guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
      return
    }
    
    // Перемещение вьюшки на высоту клавиатуры
    self.view.frame.origin.y = 0 - keyboardSize.height
  }
  
  @objc func keyboardWillHide(notification: NSNotification) {
    // Возвращаем вью в исходный размер
    self.view.frame.origin.y = 0
  }
  
}

