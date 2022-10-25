//
//  Router.swift
//  Notes
//
//  Created by Natalia Drozd on 17.10.22.
//

import Foundation
import UIKit
protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AsselderBuildProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showNotesViewController()
  //  func popToRoot()
    func showNotesViewController(notes: RealmNotesList?)
    func popToRoot()
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var assemblyBuilder: AsselderBuildProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AsselderBuildProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    // homeViewController
    func initialViewController() {
        if let navigationController = navigationController {
            guard let homeViewController = assemblyBuilder?.createModel(router: self) else { return }
            navigationController.viewControllers = [homeViewController]
        }
    }
    
    func showNotesViewController(notes: RealmNotesList?) {
        if let navigationController = navigationController {
            guard let notesViewController = assemblyBuilder?.createNotesModule(router: self, notes: notes) else {return}
            navigationController.pushViewController(notesViewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
}



//func showFlightsModule(location: String, icon: UIImage?) {
//    if let navigationController = navigationController {
//        guard let flightsViewController = assemblyBuilder?.createFlightsModule(location: location, image: icon, router: self) else { return }
//        navigationController.pushViewController(flightsViewController, animated: true)
//    }
//}
