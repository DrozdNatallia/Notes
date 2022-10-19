//
//  NotesCell.swift
//  Notes
//
//  Created by Natalia Drozd on 12.10.22.
//

import UIKit
protocol NotesCellProtocol {
    func fillField (name: String)
}
class NotesCell: UITableViewCell, NotesCellProtocol {
    @IBOutlet weak var nameNotes: UILabel!
    static let key = "NotesCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillField(name: String) {
        nameNotes.text = name
    }
    
}
