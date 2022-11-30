//
//  AppDelegate.swift
//  MovieList
//
//  Created by Sharon Omoyeni Babatunde on 30/11/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        setUpRootViewController(window: window)
        return true
    }
    
    func setUpRootViewController(window: UIWindow) {
        let movieListViewController = MovieListViewController()
        let navController = UINavigationController(rootViewController: movieListViewController)
        window.rootViewController = navController
        window.makeKeyAndVisible()
        self.window = window
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }


}

