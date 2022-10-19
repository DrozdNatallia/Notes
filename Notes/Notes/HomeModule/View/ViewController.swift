//
//  ViewController.swift
//  Notes
//
//  Created by Natalia Drozd on 11.10.22.
//

import UIKit
import RealmSwift

protocol HomeViewProtocol: AnyObject {
    
}

class ViewController: UIViewController, HomeViewProtocol {
    var presenter: HomeViewPresenterProtocol!
    var notificationToken: NotificationToken?
    @IBOutlet weak var notesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        notesTableView.delegate = self
        notesTableView.dataSource = self
        
        notesTableView.register(UINib(nibName: "NotesCell", bundle: nil), forCellReuseIdentifier: "NotesCell")
        
        var list = presenter.getListNotes(nameObject: RealmNotesList.self)
        notificationToken = list.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.notesTableView else { return }
            switch changes {
            case .initial: break
            case .update(_, let deletions, let insertions, let modifications):
            tableView.performBatchUpdates({
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                })
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    
    @IBAction func onAddNotesButton(_ sender: Any) {
        presenter.tapOnButtonEdit()
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getCountNotes()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = notesTableView.dequeueReusableCell(withIdentifier: NotesCell.key) as? NotesCell {
            presenter.configure(cell: cell, row: indexPath.row)
            return cell
        }
        return UITableViewCell()
    }
}

