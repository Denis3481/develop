//
//  TableWall.swift
//  HW
//
//  Created by Денис Шишкин on 23.03.2022.
//


import UIKit

class TableWall: UITableViewController {
  
  // MARK: -  Переменные
  private var photoItems = [PhotoItem]()
  
  // MARK: -  Методы
  //Переопределение основного метода (конструктор)
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //Настройка главной таблицы
    setupTableView()
    //Загрузка данных из сети
    PhotoItem.fetchDataFromWeb(handler: decodeData)
  }
  
  //Запуск декодирования данных из сети
  func decodeData(data: Data) {
    if let photoItems = PhotoItem.decodeDataToPhotoItems(data: data) {
      self.photoItems = photoItems
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  //Настройка + заполнение таблицы
  private func setupTableView() {
    tableView.allowsSelection = false
    tableView.separatorColor = .clear// очищаем полоску разделитель между ячейками
    
    let nib = UINib(nibName: PostTableViewCell.reuseIdentifier, bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: PostTableViewCell.reuseIdentifier)
  }
  
}

// MARK: -  Расширенные настройки
extension TableWall {

  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    260
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    photoItems.count
  }
  
  //Настройка ячейки
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let photoItem = photoItems[indexPath.row]
    
    let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier, for: indexPath) as! PostTableViewCell
    cell.photoItem = photoItem
    cell.configure()
    
    return cell
  }
  
}
