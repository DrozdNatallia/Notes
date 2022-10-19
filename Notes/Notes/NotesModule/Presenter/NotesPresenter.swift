//
//  NotesPresenter.swift
//  Notes
//
//  Created by Natalia Drozd on 17.10.22.
//

import Foundation
import UIKit

protocol NotesViewPresenterProtocol {
    func writeNotesToDatabase(text: String, name: String)
}

final class NotesViewPresenter: NotesViewPresenterProtocol {
    
    private weak var view: NotesViewProtocol?
    private var router: RouterProtocol?
    var realmProvaider: RealmProviderProtocol?
    
    required init (view: NotesViewProtocol, router: RouterProtocol, realm: RealmProviderProtocol) {
        self.view = view
        self.router = router
        self.realmProvaider = realm
    }
    
    func writeNotesToDatabase(text: String, name: String) {
        realmProvaider?.saveNotesToDatabase(text: text, name: name)
    }
}





