//
//  AppDelegate.swift
//  HW
//
//  Created by Денис Шишкин on 20.03.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()// сетап основного окна
        return true
        
    }
    
    func setupWindow(){
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TableWall() //Загрузка главного вьюконтролера
        window?.makeKeyAndVisible()
        
    }
}
    

    
    

    
    




