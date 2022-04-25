//
//  PhotoItem.swift
//  HW
//
//  Created by Денис Шишкин on 02.04.2022.
//

import UIKit

// MARK: -  Структура поста
struct PhotoItem {
  
  let id = UUID()
  let image: UIImage?
  let imageURL: String
  let author: String
  let description: String
  var likesCount: Int
  var liked: Bool {
    didSet{
      if liked {
        likesCount += 1
      } else {
        likesCount -= 1
      }
    }
  }
var comments = [Comment]()

struct Comment {
    let id = UUID()
    let author: String
    var text: String
  }
}
// MARK: -  Локализация

extension PhotoItem {
  var likesFormattedString: String {
    let formatString : String = NSLocalizedString("likes count",
                                                  comment: "Likes count string format to be found in Localized.stringsdict")
    let resultString : String = String.localizedStringWithFormat(formatString, likesCount)
    
    return resultString
  }
}


// MARK: -  Методы

//Переключатель
extension PhotoItem {
  mutating func likedToggle() {
    liked.toggle()
  }
}

//Загрузка из сети
extension PhotoItem {
  
  private struct PhotoItemFromWeb: Codable {
    let url: String
    let download_url: String
    let author: String
  }
  
  static func fetchDataFromWeb(number: Int,
                               handler: @escaping (Data) -> ()) {
    NetControllerImage.fetchData(number: number, handler: handler)
  }
  
  static func decodeDataToPhotoItems(data: Data) -> [PhotoItem]? {
    do {
      let photoItemsFromWeb = try JSONDecoder().decode([PhotoItem.PhotoItemFromWeb].self, from: data)
      
      //Конвертация
      var photoItems = [PhotoItem]()
      
      for photoItemFromWeb in photoItemsFromWeb {
        var photoItem = PhotoItem(image: nil,
                                  imageURL: photoItemFromWeb.download_url,
                                  author: photoItemFromWeb.author,
                                  description: "Good photos \(photoItemFromWeb.author)",
                                  likesCount: Int.random(in: 1...80),
                                  liked: Bool.random())
        photoItem.comments.append(PhotoItem.Comment(author: photoItem.author, text: "Good photos"))
        photoItem.comments.append(PhotoItem.Comment(author: photoItem.author, text: "Good photos"))
        photoItems.append(photoItem)
        
      }
      return photoItems
    } catch {
      print("Ошибка данных: \(error)")
    }
    return nil
  }
  
  enum CodingKeys: String, CodingKey {
    case author = "author"
    case description = "url"
  }
}
  protocol canUpdatePhotoItemInArray {
      func updatePhotoItemInArray(photoItem: PhotoItem, index: Int)
  }

