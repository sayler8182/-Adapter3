//
//  Adapter.swift
//  Adapters
//
//  Created by Konrad on 25/08/2018.
//  Copyright © 2018 Konrad. All rights reserved.
//

import Foundation
import UIKit

class Adapter: NSObject, AdapterProtocol {
    weak var list: UIList?
    var presenters: [ItemPresenter]             = []
    var sectionsPresenters: [SectionPresenter]  = []
    
    func reload(presenters: [ItemPresenter?]) {
        let indexPathes: [IndexPath] = self.indexPathes(presenters: presenters)
        self.list?.reload(indexPathes: indexPathes)
    }
    
    func reload(indexPathes: [IndexPath?]) {
        self.list?.reload(indexPathes: indexPathes)
    }
    
    func insert(indexPathes: [IndexPath?]) {
        self.list?.insert(indexPathes: indexPathes)
    }
    
    func insert(presenters: [ItemPresenter]) {
        let startIndex: Int = self.presenters.count
        self.presenters += presenters
        let endIndex: Int = self.presenters.count
        var newIndexes: [IndexPath] = []
        for i in startIndex ..< endIndex {
            newIndexes.append(IndexPath(row: i, section: 0))
        }
        self.list?.insert(indexPathes: newIndexes)
    }
    
    func insert(presenters: [SectionPresenter]) { }
    
    func reload() {
        self.list?.reloadData()
    }
    
    func set(list: UIList?) {
        self.list = list
    }
    
    func set(presenters: [ItemPresenter]) {
        self.presenters = presenters
    }
    
    func set(presenters: [SectionPresenter]) { }
    
    func indexPathes(presenters: [ItemPresenter?]) -> [IndexPath] {
        return presenters.compactMap {
            self.indexPath(presenter: $0)
        }
    }
    
    func indexPath(presenter: ItemPresenter?) -> IndexPath? {
        for (row, presenterRow) in self.presenters.enumerated() {
            guard presenterRow == presenter else { continue }
            return IndexPath(row: row, section: 0)
        }
        return nil
    }
    
    var sectionsCount: Int {
        return 1
    }
    
    func rowsCount(for section: Int) -> Int {
        return self.presenters.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionsCount
    }
    
    func size(for path: IndexPath) -> CGSize {
        guard let list: UIList = self.list else { return CGSize.zero }
        let presenter: ItemPresenter = self.presenters[path.item]
        return presenter.size(for: list, model: presenter.model)
    }
    
    func selected(at path: IndexPath) {
        DispatchQueue.main.async {
            self.presenters[path.item].selected()
        }
    }
    
    func configure(cell: UIView, at path: IndexPath) {
        self.presenters[path.item].configure(item: cell)
    }
    
    func item<T: UIView>(for path: IndexPath, with list: UIList, with type: ItemType) -> T {
        return list.item(for: path, type: ItemType.cell, id: self.presenters[path.item].id)
    }
    
    // tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rowsCount(for: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.size(for: indexPath).height
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.configure(cell: cell, at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.item(for: indexPath, with: tableView, with: ItemType.cell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selected(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    // collectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sectionsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.rowsCount(for: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.configure(cell: cell, at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.size(for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.item(for: indexPath, with: collectionView, with: ItemType.cell)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.selected(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
}
