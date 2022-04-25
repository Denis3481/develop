//
//  NetControllerImage.swift
//  HW
//
//  Created by Денис Шишкин on 31.03.2022.
//

import Foundation
import UIKit

class NetControllerImage {
  
  static func fetchData(number: Int,
                        handler: @escaping (Data) -> ()) {
    let session = URLSession.shared
    let url = URL(string: "https://picsum.photos/v2/list?page=4&limit=\(number)")!
    let task = session.dataTask(with: url) { data, response, error in
      
      if error != nil || data == nil {
        print("Ошибка клиента!")
        return
      }
      
      guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
        print("Ошибка сервера!")
        return
      }
      
      guard let mime = response.mimeType, mime == "application/json" else {
        print("Ошибка типа данных!")
        return
      }
      
      if let data = data {
        handler(data)
      } else {
        print("Ошибка данных!")
      }
    }
    
    task.resume()
  }
  static func getImage(with stringUrl: String?, completion: @escaping (UIImage?) -> ()) {
    if let stringUrl = stringUrl,
       let loadedImage = loadedImages[stringUrl] {
      DispatchQueue.main.async {
        completion(loadedImage)
      }
    }
    
    guard
      let stringUrl = stringUrl,
      let url = URL(string: stringUrl)
    else {
      completion(nil)
      return
    }
    
    // Загрузка картинки в фоновом потоке,
    DispatchQueue.global(qos: .background).async {
      let result: UIImage?
      
      if let imageData = try? Data(contentsOf: url) {
        result = UIImage(data: imageData)
        NetControllerImage.loadedImages[stringUrl] = result
      } else {
        result = nil
      }
      
      //указываем, что  передаем результат с фото в UI потоке
      DispatchQueue.main.async {
        completion(result)
      }
    }
  }
  
  static var loadedImages = [String: UIImage]()
  
}

