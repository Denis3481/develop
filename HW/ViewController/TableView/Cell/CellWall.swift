//
//  CellWall.swift
//  HW
//
//  Created by Денис Шишкин on 23.03.2022.
//


import UIKit

final class CellWall: UITableViewCell {
    
    var onButtonTap: (() -> Void)?
    @IBOutlet private var imageMain: UIImageView! // связываем элементы по средстам оутлет
    @IBOutlet private var labelUser: UILabel!
    
    @IBOutlet private var labelCount: UILabel!
    @IBOutlet private var labelImage: UILabel!
    
    
    @IBAction func buttomHeart(_ sender: UIButton){
        onButtonTap?()
    }
    
    var likesCount = (1...100).randomElement()!// указываем изначальное рандомное количество поставленных лайков
    var randomName =  ["Иван", "Петр", "Сергей", "Александр"].randomElement()!// задаем массив значений для рандомного выбора имени
    var randomNameImage = ["BMW1", "BWM2", "BMW3", "BMW4", "BMW5"].randomElement()! // задаем массив значений для рандомного выбора подписи картинки
    
    static let reuseIdentifier = String(describing: CellWall.self)
    
    var isChosen = false { // задаем переключатель лайков
        didSet {
            if isChosen {
                likesCount += 1
                
            } else {
                likesCount -= 1
            }
        
            labelCount.text = "\(likesCount)" + liketext(num: likesCount)
        }
    }
    func liketext(num:Int)->String{ // объявляем функцию для склонения количества лайков, с помощью деления с остатком и оператор ветвления для разных вариантов
        
        var y = " "
        var l_result = " "
        switch num%10
        {
        case 0, 5, 6, 7, 8, 9: y = "ов"
        
         case 1: y = ""
            
         case 2, 3, 4: y = "a"
        default:break
        }
        l_result = " Лайк" + y
        return l_result
    }
    
    func configure(image: UIImage) {// задаем свойства переменных
        labelImage.text = "\(randomNameImage)"
        labelUser.text = "\(randomName)"
        labelCount.text = "\(likesCount)" + liketext(num: likesCount)
        imageMain.clipsToBounds = true
        imageMain.layer.cornerRadius = 8
        imageMain.image = image
        selectionStyle = .none
    }
    
    func update(isChosen: Bool) {
        
    }
}
