//
//  SceneDelegate.swift
//  Millionaire
//
//  Created by Ksenia Maricheva on 15.05.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // указываем границы окна
        //UIScreen.main.bounds - границы экрана
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        // сцена - рабочая область
        window?.windowScene = windowScene
        //добавляем корневой контролер в окно
        window?.rootViewController = UINavigationController(
            rootViewController: MainViewController()
        )
        window?.makeKeyAndVisible()
    }
}

