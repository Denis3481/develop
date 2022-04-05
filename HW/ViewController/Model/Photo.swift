//
//  Photo.swift
//  HW
//
//  Created by Денис Шишкин on 02.04.2022.
//

import UIKit

// MARK: -  Структура поста
struct PhotoItem {
  let image: UIImage
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
  
  static func fetchDataFromWeb(handler: @escaping (Data) -> Void) {
    NetControllerImage.fetchData(handler: handler)
  }
  
  static func decodeDataToPhotoItems(data: Data) -> [PhotoItem]? {
    do {
      let photoItemsFromWeb = try JSONDecoder().decode([PhotoItem.PhotoItemFromWeb].self, from: data)
      
      //Конвертация
      var photoItems = [PhotoItem]()
      
      for photoItemFromWeb in photoItemsFromWeb {
        
        var uiImage = UIImage()
        
        if let url = URL(string: photoItemFromWeb.download_url), let data = try? Data(contentsOf: url) {
          if let image = UIImage(data: data) {
            uiImage = image
          }
        }
        
        let photoItem = PhotoItem(image: uiImage,
                                  author: "Denis Shishkin",
                                  description: "\(photoItemFromWeb.author)",
                                  likesCount: Int.random(in: 1...80),
                                  liked: Bool.random())
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
