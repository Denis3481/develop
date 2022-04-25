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
    window = .init(frame: UIScreen.main.bounds)
    
    //Загрузка главного вьюконтролера
    window?.rootViewController = UINavigationController(rootViewController: MainScreenViewController())
    window?.makeKeyAndVisible()
    
    return true
  }
}











