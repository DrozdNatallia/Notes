//
//  RealmProvaider.swift
//  Notes
//
//  Created by Natalia Drozd on 17.10.22.
//

import Foundation
import RealmSwift
import UIKit

protocol RealmProviderProtocol {
    func saveNotesToDatabase(text: String, name: String)
    func deleteNotesFromDatabase(name: Object)
    func getResult<T: RealmFetchable>(nameObject: T.Type) -> Results<T>
    func editNotes(oldNotes: RealmNotesList?, newtext: String)
}

class RealmProvader: RealmProviderProtocol {
    private let realm = try! Realm()
    func writeObjectToDatabase(name: Object) {
        try! realm.write {
            realm.add(name)
        }
    }
    func deleteNotesFromDatabase(name: Object) {
        try! realm.write {
            realm.delete(name)
        }
    }
    func getResult<T: RealmFetchable>(nameObject: T.Type) -> Results<T> {
        realm.objects(nameObject.self)
    }
    
    func saveNotesToDatabase(text: String, name: String) {
        let newNotes = RealmNotesList()
        newNotes.name = name
        newNotes.notes = text
        writeObjectToDatabase(name: newNotes)
    }
    
    func editNotes(oldNotes: RealmNotesList?, newtext: String){
      guard var realmNotes = oldNotes else { return }
        try! realm.write {
            realmNotes.notes = newtext
        }
    }
}
