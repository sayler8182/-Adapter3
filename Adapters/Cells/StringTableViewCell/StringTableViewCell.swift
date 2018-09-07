//
//  StringTableViewCell.swift
//  Adapters
//
//  Created by Konrad on 25/08/2018.
//  Copyright © 2018 Konrad. All rights reserved.
//

import Foundation
import UIKit

class StringCellPresenter: ItemPresenter {
    var id: String {
        return StringTableViewCell.reusableIdentifier
    }
    var model: ItemModel?
    
    init(model: ItemModel?) {
        self.model = model
    }
    
    func size(for list: UIList, model: ItemModel?) -> CGSize {
        return CGSize(width: list.bounds.width, height: 44)
    }
    
    func configure(item: UIView) {
        let cell: StringTableViewCell = item as! StringTableViewCell
        let model: String? = self.model as? String
        cell.titleLabel.text = model
    }
    
    func selected() { }
}

class StringTableViewCell: UITableViewCell, CellProtocol {
    static var reusableIdentifier: String {
        return "StringTableViewCell"
    }
    
    static var nib: UINib {
        return UINib(nibName: "StringTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var titleLabel: UILabel!
}
