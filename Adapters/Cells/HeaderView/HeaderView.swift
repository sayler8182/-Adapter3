//
//  HeaderView.swift
//  Adapters
//
//  Created by Konrad on 07/09/2018.
//  Copyright © 2018 Konrad. All rights reserved.
//

import Foundation
import UIKit

class HeaderViewPresenter: ItemPresenter {
    var id: String {
        return HeaderView.reusableIdentifier
    }
    var model: ItemModel?
    
    init(model: ItemModel?) {
        self.model = model
    }
    
    func size(for list: UIList, model: ItemModel?) -> CGSize {
        return CGSize(width: list.bounds.width, height: 44)
    }
    
    func configure(item: UIView) {
        let view: HeaderView = item as! HeaderView
        let model: String? = self.model as? String
        view.titleLabel.text = model?.description
    }
    
    func selected() { }
}

class HeaderView: UITableViewHeaderFooterView, CellProtocol {
    static var reusableIdentifier: String {
        return "HeaderView"
    }
    
    static var nib: UINib {
        return UINib(nibName: "HeaderView", bundle: nil)
    }
    
    @IBOutlet weak var titleLabel: UILabel!
}
