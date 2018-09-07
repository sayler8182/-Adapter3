//
//  Item.swift
//  Adapters
//
//  Created by Konrad on 25/08/2018.
//  Copyright © 2018 Konrad. All rights reserved.
//

import Foundation
import UIKit

enum ItemType {
    case cell
    case header
    case footer
    
    var value: String {
        switch self {
        case .cell:     return "cell"
        case .header:   return UICollectionElementKindSectionHeader
        case .footer:   return UICollectionElementKindSectionFooter
        }
    }
    
    init(string: String) {
        switch string {
        case UICollectionElementKindSectionHeader:  self = ItemType.header
        case UICollectionElementKindSectionFooter:  self = ItemType.footer
        default:                                    self = ItemType.cell
        }
    }
}
protocol ItemModel { }
protocol ItemPresenter {
    var id: String          { get }
    var model: ItemModel?   { get set }
    
    func size(for list: UIList, model: ItemModel?) -> CGSize
    func configure(item: UIView)
    func selected()
}

protocol SectionPresenter {
    var header: ItemPresenter? { get }
    var subitems: [ItemPresenter] { get set }
    var footer: ItemPresenter? { get set }
}

private struct AssociationKeys {
    static var ItemPresenterUniqueID: UInt8 = 0
}

extension ItemPresenter {
    var uniqueID: String {
        get {
            guard let string = objc_getAssociatedObject(self, &AssociationKeys.ItemPresenterUniqueID) as? String else {
                let string = UUID().uuidString
                objc_setAssociatedObject(self, &AssociationKeys.ItemPresenterUniqueID, string, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
                return string
            }
            return string
        }
        set { objc_setAssociatedObject(self, &AssociationKeys.ItemPresenterUniqueID, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
}

func == (lhs: ItemPresenter?, rhs: ItemPresenter?) -> Bool {
    return lhs?.uniqueID == rhs?.uniqueID
}

// MARK: CellProtocol
protocol CellProtocol {
    static var reusableIdentifier: String { get }
    static var nib: UINib { get }
}

extension String: ItemModel { }
extension Int: ItemModel { }
