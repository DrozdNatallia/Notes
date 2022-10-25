//
//  Presenter.swift
//  Notes
//
//  Created by Natalia Drozd on 17.10.22.
//

import Foundation
import UIKit
import RealmSwift

protocol HomeViewPresenterProtocol {
    func tapOnButtonEdit()
    func configure(cell: NotesCellProtocol, row: Int)
    func getCountNotes() -> Int
    func getListNotes<T: RealmFetchable>(nameObject: T.Type) -> Results<T>
    func deleteNotesFromDatabase(name: Object)
    
}

final class HomeViewPresenter: HomeViewPresenterProtocol {
    
    private weak var view: HomeViewProtocol?
    private var router: RouterProtocol?
    var realmProvaider: RealmProviderProtocol?
    
    required init (view: HomeViewProtocol, router: RouterProtocol, realm: RealmProviderProtocol) {
        self.view = view
        self.router = router
        self.realmProvaider = realm
    }
    
    func tapOnButtonEdit() {
        router?.showNotesViewController()
    }
    
    
    func getCountNotes() -> Int {
        guard let res = realmProvaider?.getResult(nameObject: RealmNotesList.self).count else { return 0 }
        return res
    }
    
    func configure(cell: NotesCellProtocol, row: Int) {
        let res = realmProvaider?.getResult(nameObject: RealmNotesList.self)[row]
        let name = res?.notes
        cell.fillField(name: name!)
    }
    

    func getListNotes<T: RealmFetchable>(nameObject: T.Type) -> Results<T> {
        return realmProvaider?.getResult(nameObject: RealmNotesList.self) as! Results<T>
    }
    
    func deleteNotesFromDatabase(name: Object) {
        realmProvaider?.deleteNotesFromDatabase(name: name)
    }
}
