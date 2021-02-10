//
//  Router.swift
//  beautifulTasks
//
//  Created by José João Silva Nunes Alves on 10/02/21.
//

import UIKit

struct Router {
    static func maincController() -> UIViewController {

        let navigation = UINavigationController()
        navigation.navigationBar.barTintColor = UIColor(named: "backgroundColor")
        navigation.navigationBar.isTranslucent = false
        navigation.navigationBar.shadowImage = UIImage()

        let mainViewController = DaysTasksViewController()
        navigation.viewControllers = [mainViewController]

        return navigation
    }
}
