//
//  NotesViewController.swift
//  Notes
//
//  Created by Natalia Drozd on 12.10.22.
//

import UIKit
import RealmSwift

protocol NotesViewProtocol: AnyObject {
    
}

class NotesViewController: UIViewController, NotesViewProtocol {
    var presenter: NotesViewPresenterProtocol!
    var notesRealm: RealmNotesList!
    @IBOutlet weak var textArea: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(didTapDoneButton))
        guard let notesRealm = notesRealm else { return }
        textArea.text = notesRealm.notes
    }

    @objc func didTapDoneButton(){
        guard let text = textArea.text else { return }
        if notesRealm == nil {
            presenter.writeNotesToDatabase(text: text, name: "newNotes")
        } else {
            presenter.editNotes(notes: notesRealm, text: text)
        }
        presenter.popToRoot()

//        let realm = try! Realm()
//       print(realm.configuration.fileURL)
    }
}
