//
//  AppDelegate.swift
//  Adapters
//
//  Created by Konrad on 25/08/2018.
//  Copyright © 2018 Konrad. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let dashboardView: DashboardViewProtocol = DashboardViewController()
        let adapter: AdapterProtocol = SectionedAdapter()
        let presenter: DashboardPresenter = DashboardPresenter(
            view: dashboardView,
            adapter: adapter)
        dashboardView.presenter = presenter
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = dashboardView as? UIViewController
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

