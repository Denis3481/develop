//
//  NetController.swift
//  HW
//
//  Created by Денис Шишкин on 31.03.2022.
//

import Foundation

class NetControllerImage {
  
  static func fetchData(handler: @escaping (Data) -> Void) {
    
    let session = URLSession.shared
    let url = URL(string: "https://picsum.photos/v2/list")!
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
  
}
