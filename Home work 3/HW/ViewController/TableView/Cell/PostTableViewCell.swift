//
//  PostTableViewCell.swift
//  HW
//
//  Created by Денис Шишкин on 23.03.2022.
//


import UIKit

final class PostTableViewCell: UITableViewCell, UIScrollViewDelegate {
  
  // MARK: -  Переменные
  
  // связываем элементы по средстам оутлет
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet private var viewTap: UIView!
  @IBOutlet private var imageMain: UIImageView!
  @IBOutlet private var labelUser: UILabel!
  @IBOutlet private var labelCount: UILabel!
  @IBOutlet weak var loadingActivitySpiner: UIActivityIndicatorView!
  @IBOutlet private var labelImage: UILabel!
  @IBOutlet weak var heartButton: UIButton!
  @IBOutlet weak var commentsButton: UIButton!
  @IBAction func buttomHeart(_ sender: Any) {
    likedToggle()
    updateLikesInfo()
  }
  @IBAction func commentsButtonTaped(_ sender: Any) { navigationHandler!(photoItem!, cellIndex)
  }
  
  var photoItem: PhotoItem?
  var cellIndex: Int = 0
  var navigationHandler: ((PhotoItem, Int) -> ())? = nil
  
  static let reuseIdentifier = String(describing: PostTableViewCell.self)
  
}
extension PostTableViewCell {
  
  override func prepareForReuse() {
    super.prepareForReuse()
    imageMain.image = nil
  }
  
}

// MARK: -  UIScrollViewDelegate
extension PostTableViewCell{
  
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return imageMain
  }
  
  func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
    scrollView.zoomScale = 1.0
  }
  
}


// MARK: -  Функции
extension PostTableViewCell {
  
  func setImageToCell(uiImage: UIImage?) {
    if let uiImage = uiImage{
      imageMain.image = uiImage
      loadingActivitySpiner.isHidden = true
    }
  }
  
  func configure() {
    
    selectionStyle = .none
    scrollView.clipsToBounds = true
    scrollView.layer.cornerRadius = 6
    self.viewTap.alpha = 0
    
    NetControllerImage.getImage(with: photoItem!.imageURL,
                                completion: setImageToCell)
    
    labelUser.text = photoItem!.author
    labelImage.text = photoItem!.description
    commentsButton.setTitle("Комментарии (\(photoItem!.comments.count))", for: .normal)
    
    updateLikesInfo()
    
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
    tapGestureRecognizer.numberOfTapsRequired = 2
    
//    imageMain.isUserInteractionEnabled = true
//    imageMain.addGestureRecognizer(tapGestureRecognizer)
    
    scrollView.delegate = self
    scrollView.minimumZoomScale = 1.0
    scrollView.maximumZoomScale = 10.0
    
  }
  
  @objc private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
    if photoItem!.liked == false
    {
      viewTap.alpha = 1
      PostTableViewCell.animate(withDuration: 1.0) {
        self.viewTap.alpha = 0
      }
      likedToggle()
    }
  }
  
  
  private func updateLikesInfo() {
    labelCount.text = photoItem!.likesFormattedString
    heartButton.alpha = photoItem!.liked ? 1 : 0.3
  }
  
  private func likedToggle() {
    photoItem!.likedToggle()
    updateLikesInfo()
  }
  
}
