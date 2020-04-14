//
//  SceneDelegate.swift
//  Covid19Data
//
//  Created by Leonardo D'Amato on 5/4/20.
//  Copyright © 2020 Leonardo D'Amato. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        configureNavBarAppearance()
        window?.backgroundColor = .systemBackground
        window?.rootViewController = configureTabbar()
        window?.makeKeyAndVisible()
    }
    
    func configureHomeNavController() -> UINavigationController {
        //let nav = UINavigationController(rootViewController: HomeViewController())
        let nav = UINavigationController(rootViewController: GlobalViewController())
        nav.title = "Global"
        let image = UIImage(systemName: "globe")?.withTintColor(.systemTeal)
        nav.tabBarItem = UITabBarItem(title: "Global", image: image, tag: 0)
        return nav
    }
    
    func configureCountriesNavController() -> UINavigationController {
        let nav = UINavigationController(rootViewController: CountriesViewController())
        nav.title = "Countries"
        let image = UIImage(systemName: "flag")
        nav.tabBarItem = UITabBarItem(title: "Countries", image: image, tag: 1)
        return nav
    }
    
    func configureNewsNavController() -> UINavigationController {
        let nav = UINavigationController(rootViewController: NewsListViewController())
        nav.title = "News"
        let image = UIImage(systemName: "book")
        nav.tabBarItem = UITabBarItem(title: "News", image: image, tag: 2)
        return nav
    }
    
    func configureSettingsNavController() -> UINavigationController {
        let nav = UINavigationController(rootViewController: MainSettingsViewController())
        nav.title = "Settings"
        let image = UIImage(systemName: "gear")
        nav.tabBarItem = UITabBarItem(title: "Settings", image: image, tag: 3)
        return nav
    }
    
    func configureNavBarAppearance() {
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().barTintColor = .systemTeal
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = .systemTeal
    }
    
    func configureTabbar() -> UITabBarController {
        let tabbar = UITabBarController()
        UITabBar.appearance().tintColor = .systemTeal
        tabbar.viewControllers = [
            configureHomeNavController(),
            configureCountriesNavController(),
            configureNewsNavController(),
            configureSettingsNavController()
        ]
        
        return tabbar
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

