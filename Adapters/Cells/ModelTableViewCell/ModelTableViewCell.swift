//
//  ModelTableViewCell.swift
//  Adapters
//
//  Created by Konrad on 27/08/2018.
//  Copyright © 2018 Konrad. All rights reserved.
//

import Foundation
import UIKit

class ModelCellPresenter: ItemPresenter {
    var id: String {
        return ModelTableViewCell.reusableIdentifier
    }
    var model: ItemModel?
    
    init(model: ItemModel?) {
        self.model = model
    }
    
    func size(for list: UIList, model: ItemModel?) -> CGSize {
        return CGSize(width: list.bounds.width, height: 44)
    }
    
    func configure(item: UIView) {
        let cell: ModelTableViewCell = item as! ModelTableViewCell
        let model: Model? = self.model as? Model
        cell.titleLabel.text = model?.description
    }
    
    func selected() { }
}

class ModelTableViewCell: UITableViewCell, CellProtocol {
    static var reusableIdentifier: String {
        return "ModelTableViewCell"
    }
    
    static var nib: UINib {
        return UINib(nibName: "ModelTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var titleLabel: UILabel!
}
