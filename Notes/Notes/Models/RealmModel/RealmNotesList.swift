//
//  RealmNotesList.swift
//  Notes
//
//  Created by Natalia Drozd on 17.10.22.
//

import Foundation
import UIKit
import RealmSwift

class RealmNotesList: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var notes: String = ""
}
