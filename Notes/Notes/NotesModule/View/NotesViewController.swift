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

    @IBOutlet weak var textArea: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(didTapDoneButton))
    }

    @objc func didTapDoneButton(){
        guard let text = textArea.text else { return }
        presenter.writeNotesToDatabase(text: text, name: "newNotes")
        let realm = try! Realm()
       print(realm.configuration.fileURL)

    }
}
