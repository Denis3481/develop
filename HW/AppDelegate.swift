//
//  AppDelegate.swift
//  HW
//
//  Created by Денис Шишкин on 20.03.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {  //Объявляем класс

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()// делаем сетап переменной
        return true
        
    }
    
    func setupWindow(){
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TableWall() //Загружаем наш вьюконтролер
        window?.makeKeyAndVisible()
        
    }
}
    

    
    

    
    




