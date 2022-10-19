//
//  ModelBuilder.swift
//  Notes
//
//  Created by Natalia Drozd on 17.10.22.
//

import Foundation
import UIKit

protocol AsselderBuildProtocol {
    func createModel(router: RouterProtocol) -> UIViewController
    func createNotesModule(router: RouterProtocol)-> UIViewController
}

class BuilderClass: AsselderBuildProtocol {
    
    func createModel(router: RouterProtocol)-> UIViewController {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            let realmProvaider = RealmProvader()
            let presenter = HomeViewPresenter(view: viewController, router: router, realm: realmProvaider)
            viewController.presenter = presenter
            return viewController
            
        }
        return UIViewController()
    }
    
    func createNotesModule(router: RouterProtocol)-> UIViewController {
        let viewController = NotesViewController(nibName: "NotesViewController", bundle: nil)
        let realmProvaider = RealmProvader()
        let presenter = NotesViewPresenter(view: viewController, router: router, realm: realmProvaider)
        viewController.presenter = presenter
        return viewController
    }
}
