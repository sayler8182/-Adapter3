//
//  IntTableViewCell.swift
//  Adapters
//
//  Created by Konrad on 27/08/2018.
//  Copyright © 2018 Konrad. All rights reserved.
//

import Foundation
import UIKit

class IntCellPresenter: ItemPresenter {
    var id: String {
        return IntTableViewCell.reusableIdentifier
    }
    var model: ItemModel?
    
    init(model: ItemModel?) {
        self.model = model
    }
    
    func size(for list: UIList, model: ItemModel?) -> CGSize {
        return CGSize(width: list.bounds.width, height: 44)
    }
    
    func configure(item: UIView) {
        let cell: IntTableViewCell = item as! IntTableViewCell
        let model: Int? = self.model as? Int
        cell.titleLabel.text = model?.description
    }
    
    func selected() { }
}

class IntTableViewCell: UITableViewCell, CellProtocol {
    static var reusableIdentifier: String {
        return "IntTableViewCell"
    }
    
    static var nib: UINib {
        return UINib(nibName: "IntTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var titleLabel: UILabel!
}
