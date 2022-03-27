//
//  TableWall.swift
//  HW
//
//  Created by Денис Шишкин on 23.03.2022.
//


import UIKit

class TableWall: UITableViewController {

        
    let images = (1...14).map{ UIImage(named: String($0))! } //задаем массив с закрытым диапазоном и извлекаем изображение
    

    override func viewDidLoad() { //выполняем переопределение
        super.viewDidLoad()
        setupTableView() //делаем сетап
    }
    
    private func setupTableView() {
        tableView.allowsSelection = false
        tableView.separatorColor = .clear
        
        let nib = UINib(nibName: CellWall.reuseIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CellWall.reuseIdentifier)
    }

}

extension TableWall {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        images.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellWall.reuseIdentifier, for: indexPath) as! CellWall
        cell.configure(image: images[indexPath.row])
        cell.onButtonTap = {
            cell.isChosen.toggle()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? CellWall
        
        cell?.isChosen.toggle()
    }
    
    
}
