//
//  UIList.swift
//  Adapters
//
//  Created by Konrad on 25/08/2018.
//  Copyright © 2018 Konrad. All rights reserved.
//

import Foundation
import UIKit

protocol UIList: class {
    var bounds: CGRect { get }
    var frame: CGRect { get }
    
    func item<T: UIView>(`for` path: IndexPath, type: ItemType, id: String) -> T
    func set(adapter: AdapterProtocol)
    func reload(indexPathes: [IndexPath?])
    func insert(indexPathes: [IndexPath?])
    func reloadData()
    func updates(_ closure: () -> Void)
}

// MARK: UITableView
extension UITableView: UIList {
    func set(adapter: AdapterProtocol) {
        self.dataSource = adapter
        self.delegate = adapter
        adapter.set(list: self)
    }
    
    func register(type: CellProtocol.Type, itemType: ItemType = ItemType.cell) {
        switch itemType {
        case .header:   return self.register(type.nib, forHeaderFooterViewReuseIdentifier: type.reusableIdentifier)
        case .footer:   return self.register(type.nib, forHeaderFooterViewReuseIdentifier: type.reusableIdentifier)
        case .cell:     return self.register(type.nib, forCellReuseIdentifier: type.reusableIdentifier)
        }
    }
    
    func item<T: UIView>(for path: IndexPath, type: ItemType, id: String) -> T {
        switch type {
        case .header:   return self.dequeueReusableHeaderFooterView(withIdentifier: id) as! T
        case .footer:   return self.dequeueReusableHeaderFooterView(withIdentifier: id) as! T
        case .cell:     return self.dequeueReusableCell(withIdentifier: id, for: path) as! T
        }
    }
    
    func reload(indexPathes: [IndexPath?]) {
        let indexPathes: [IndexPath] = indexPathes.compactMap { $0 }
        self.beginUpdates()
        self.reloadRows(at: indexPathes, with: UITableViewRowAnimation.automatic)
        self.endUpdates()
    }
    
    func insert(indexPathes: [IndexPath?]) {
        let indexPathes: [IndexPath] = indexPathes.compactMap { $0 }
        self.beginUpdates()
        self.insertRows(at: indexPathes, with: UITableViewRowAnimation.automatic)
        self.endUpdates()
    }
    
    func updates(_ closure: () -> Void) {
        self.beginUpdates()
        closure()
        self.endUpdates()
    }
}

// MARK: UICollectionView
extension UICollectionView: UIList {
    func set(adapter: AdapterProtocol) {
        self.dataSource = adapter
        self.delegate = adapter
        adapter.set(list: self)
    }
    
    func register(type: CellProtocol.Type, itemType: ItemType = ItemType.cell) {
        switch itemType {
        case .header:   return self.register(type.nib, forSupplementaryViewOfKind: itemType.value, withReuseIdentifier: type.reusableIdentifier)
        case .footer:   return self.register(type.nib, forSupplementaryViewOfKind: itemType.value, withReuseIdentifier: type.reusableIdentifier)
        case .cell:     return self.register(type.nib, forCellWithReuseIdentifier: type.reusableIdentifier)
        }
    }
    
    func item<T: UIView>(for path: IndexPath, type: ItemType, id: String) -> T {
        switch type {
        case .header:   return self.dequeueReusableSupplementaryView(ofKind: type.value, withReuseIdentifier: id, for: path) as! T
        case .footer:   return self.dequeueReusableSupplementaryView(ofKind: type.value, withReuseIdentifier: id, for: path) as! T
        case .cell:     return self.dequeueReusableCell(withReuseIdentifier: id, for: path) as! T
        }
    }
    
    func reload(indexPathes: [IndexPath?]) {
        let indexPathes: [IndexPath] = indexPathes.compactMap { $0 }
        self.reloadItems(at: indexPathes)
    }
    
    func insert(indexPathes: [IndexPath?]) {
        let indexPathes: [IndexPath] = indexPathes.compactMap { $0 }
        self.insertItems(at: indexPathes)
    }
    
    func updates(_ closure: () -> Void) {
        self.performBatchUpdates(closure, completion: nil)
    }
}
