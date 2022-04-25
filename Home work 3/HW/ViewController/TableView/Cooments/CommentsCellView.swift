//
//  CommentsCellView.swift
//  HW
//
//  Created by Денис Шишкин on 11.04.2022.
//

import UIKit

class CommentsCellView: UITableViewCell {
  
  
  
  @IBOutlet weak var authorComments: UILabel!
  
  @IBOutlet weak var comments: UILabel!
  
  static let reuseIdentifier = String(describing: CommentsCellView.self)
  
  var comment: PhotoItem.Comment?
  
  
  func configure() {
    selectionStyle = .none
    
    authorComments.text = comment?.author
    comments.text = comment?.text
  }
  
}
