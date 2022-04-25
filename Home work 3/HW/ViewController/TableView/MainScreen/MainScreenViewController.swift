//
//  MainScreenViewController.swift
//  HW
//
//  Created by Денис Шишкин on 23.03.2022.
//


import UIKit

final class MainScreenViewController: UIViewController {
 
  @IBOutlet weak var refreshLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
  // MARK: -  Переменные
  private var photoItems = [PhotoItem]()

  // MARK: -  Методы
  //Переопределение основного метода (конструктор)
  override func viewDidLoad() {
    super.viewDidLoad()

    //Настройка главной таблицы
    setupTableView()
    refreshLabel.text = "Loading..."
    //Загрузка данных из сети
    PhotoItem.fetchDataFromWeb(number: 5, handler: decodeData)
  }

  //Декодирование данных из сети
  func decodeData(data: Data) {
    if let photoItems = PhotoItem.decodeDataToPhotoItems(data: data) {
    self.photoItems.insert(contentsOf: photoItems, at: 0)
    DispatchQueue.main.async {
        self.tableView.refreshControl?.endRefreshing()
        self.refreshLabel.isHidden = true
        self.loadingActivityIndicator.isHidden = true
        self.tableView.reloadData()
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(self.callPullToRefresh), for: .valueChanged)
      }
    }
  }
  //Настройка и заполнение таблицы
  private func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.tableFooterView = UIView()
    tableView.allowsSelection = false
    
    // очищаем полоску разделитель между ячейками
    tableView.separatorColor = .clear
    
    let nib = UINib(nibName: PostTableViewCell.reuseIdentifier, bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: PostTableViewCell.reuseIdentifier)
    navigationItem.title = "Фотографии"
  }

@objc func callPullToRefresh(){
    PhotoItem.fetchDataFromWeb(number: 1, handler: decodeData)
}

func navigateToComments(photoItem: PhotoItem, cellIndex: Int) {
    let vc = CommentsListViewController(photoItem: photoItem,
                                        indexPhotoItemInArray: cellIndex,
                                        delegate: self)
    navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: -  Расширенные настройки
extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource {

   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
  280
   }

   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    photoItems.count
   }

  //Настройки ячейки
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let photoItem = photoItems[indexPath.row]

    let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier, for: indexPath) as! PostTableViewCell
    cell.photoItem = photoItem
    cell.configure()
    cell.cellIndex = indexPath.row
    cell.navigationHandler = navigateToComments

    return cell
  }

}
// MARK: -  canUpdatePhotoItemInArray
extension MainScreenViewController: canUpdatePhotoItemInArray {
    func updatePhotoItemInArray(photoItem: PhotoItem, index: Int) {
        if 0...photoItems.count - 1 ~= index {
            photoItems[index] = photoItem
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
    }
}
