//
//  PostTableViewCell.swift
//  HW
//
//  Created by Денис Шишкин on 23.03.2022.
//


import UIKit

final class PostTableViewCell: UITableViewCell, UIScrollViewDelegate {
  
  // MARK: -  Переменные
  
  // связываем элементы по средстам оутле
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet private var viewTap: UIView!
  @IBOutlet private var imageMain: UIImageView!
  @IBOutlet private var labelUser: UILabel!
  @IBOutlet private var labelCount: UILabel!
  @IBOutlet private var labelImage: UILabel!
  
  @IBAction func buttomHeart(_ sender: UIButton) {
    likedToggle()
  }
  
  var likesCount = (1...80).randomElement()!
  var Name =  "Denis Shishkin"
  var NameImage = "BMW"
  var photoItem: PhotoItem?
  
  static let reuseIdentifier = String(describing: PostTableViewCell.self)
  
  // MARK: -  Методы
  
  // Настройка ячейки
  func configure() {
    //print("configure")
    
    //Приемник входных данных
    if let photoItem = photoItem {
      imageMain.image = photoItem.image
      labelUser.text = photoItem.author
      labelImage.text = photoItem.description
      
      //Обновляем лайки
      updateLikesInfo()
    }
   
    imageMain.clipsToBounds = true
    imageMain.layer.cornerRadius = 6
    selectionStyle = .none
    self.viewTap.alpha = 0

    scrollView.delegate = self
    scrollView.minimumZoomScale = 1.0
    scrollView.maximumZoomScale = 10.0
    
    //Двойное нажатие
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(Tapped(tapGestureRecognizer:)))
    tapGestureRecognizer.numberOfTapsRequired = 2
    imageMain.isUserInteractionEnabled = true
    imageMain.addGestureRecognizer(tapGestureRecognizer)
  }
  
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
   // print("zoom")
    
    return imageMain
  }
  
  private func scrollViewDidEndZooming(_ scrollView: UIScrollView,
                                       with view: UIView?,
                                       atScale scale: CGFloat) -> UIView? {
    return imageMain
  }
  
  @objc private func Tapped(tapGestureRecognizer: UITapGestureRecognizer) {
    likedToggle()
  }
  
  private func likedToggle() {
    viewTap.alpha = 1
    PostTableViewCell.animate(withDuration: 1.0) {
      self.viewTap.alpha = 0
    }
    
    photoItem?.likedToggle()
    updateLikesInfo()
  }
  
  private func updateLikesInfo() {
    if let photoItem = photoItem {
      labelCount.text = photoItem.likesFormattedString
    }
  }
  
}


