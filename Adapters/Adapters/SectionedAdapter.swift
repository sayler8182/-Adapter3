//
//  SectionedAdapter.swift
//  Adapters
//
//  Created by Konrad on 05/09/2018.
//  Copyright © 2018 Konrad. All rights reserved.
//

import Foundation
import UIKit

class SectionedAdapter: NSObject, AdapterProtocol {
    weak var list: UIList?
    var presenters: [ItemPresenter]             = []
    var sectionsPresenters: [SectionPresenter]  = []
    
    func reload(presenters: [ItemPresenter?]) {
        let indexPathes: [IndexPath] = self.indexPathes(presenters: presenters)
        self.reload(indexPathes: indexPathes)
    }
    
    func reload(indexPathes: [IndexPath?]) {
        self.list?.reload(indexPathes: indexPathes)
    }
    
    func insert(indexPathes: [IndexPath?]) {
        self.list?.insert(indexPathes: indexPathes)
    }
    
    func insert(presenters: [ItemPresenter]) { }
    
    func insert(presenters: [SectionPresenter]) { }
    
    func reload() {
        self.list?.reloadData()
    }
    
    func set(list: UIList?) {
        self.list = list
    }
    
    func set(presenters: [ItemPresenter]) { }
    
    func set(presenters: [SectionPresenter]) {
        self.sectionsPresenters = presenters
    }
    
    func indexPathes(presenters: [ItemPresenter?]) -> [IndexPath] {
        var indexes: [IndexPath] = []
        for (section, presenterSection) in self.sectionsPresenters.enumerated() {
            for (row, presenterRow) in presenterSection.subitems.enumerated() {
                guard presenters.contains(where: { $0 == presenterRow }) else { continue }
                indexes.append(IndexPath(row: row, section: section))
            }
        }
        return indexes
    }
    
    func indexPath(presenter: ItemPresenter?) -> IndexPath? {
        for (section, presenterSection) in self.sectionsPresenters.enumerated() {
            for (row, presenterRow) in presenterSection.subitems.enumerated() {
                guard presenterRow == presenter else { continue }
                return IndexPath(row: row, section: section)
            }
        }
        return nil
    }
    
    var sectionsCount: Int {
        return self.sectionsPresenters.count
    }
    
    func rowsCount(for section: Int) -> Int {
        return self.sectionsPresenters[section].subitems.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionsCount
    }
    
    func size(for path: IndexPath) -> CGSize {
        guard let list: UIList = self.list else { return CGSize.zero }
        let presenter: ItemPresenter = self.sectionsPresenters[path.section].subitems[path.item]
        return presenter.size(for: list, model: presenter.model)
    }
    
    func selected(at path: IndexPath) {
        DispatchQueue.main.async {
            self.sectionsPresenters[path.section].subitems[path.item].selected()
        }
    }
    
    func configure(cell: UIView, at path: IndexPath) {
        self.sectionsPresenters[path.section].subitems[path.item].configure(item: cell)
    }
    
    func item<T>(for path: IndexPath, with list: UIList, with type: ItemType) -> T where T : UIView {
        return list.item(for: path, type: type, id: self.sectionsPresenters[path.section].subitems[path.item].id)
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
        guard let list: UIList = self.list else { return CGFloat.leastNormalMagnitude }
        guard let header: ItemPresenter = self.sectionsPresenters[section].header else { return CGFloat.leastNormalMagnitude }
        return header.size(for: list, model: header.model).height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header: ItemPresenter = self.sectionsPresenters[section].header else { return nil }
        let item: UIView = tableView.item(for: IndexPath(row: 0, section: 0), type: ItemType.header, id: header.id)
        header.configure(item: item)
        return item
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let list: UIList = self.list else { return CGFloat.leastNormalMagnitude }
        guard let footer: ItemPresenter = self.sectionsPresenters[section].footer else { return CGFloat.leastNormalMagnitude }
        return footer.size(for: list, model: footer.model).height
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer: ItemPresenter = self.sectionsPresenters[section].footer else { return nil }
        let item: UIView = tableView.item(for: IndexPath(row: 0, section: 0), type: ItemType.footer, id: footer.id)
        footer.configure(item: item)
        return item
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
        guard let list: UIList = self.list else { return CGSize.zero }
        guard let header: ItemPresenter = self.sectionsPresenters[section].header else { return CGSize.zero }
        return header.size(for: list, model: header.model)
    }
    
    @objc func collectionView(_ collectionView: UICollectionView, layout  collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard let list: UIList = self.list else { return CGSize.zero }
        guard let footer: ItemPresenter = self.sectionsPresenters[section].footer else { return CGSize.zero }
        return footer.size(for: list, model: footer.model)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let type: ItemType = ItemType(string: kind)
        switch type {
        case ItemType.header:
            guard let header: ItemPresenter = self.sectionsPresenters[indexPath.section].header else { break }
            let item: UICollectionReusableView = collectionView.item(for: indexPath, type: type, id: header.id)
            self.sectionsPresenters[indexPath.section].header?.configure(item: item)
            return item
        case ItemType.cell:
            let item: UICollectionReusableView = collectionView.item(for: indexPath, type: type, id: self.sectionsPresenters[indexPath.section].subitems[indexPath.row].id)
            self.sectionsPresenters[indexPath.section].subitems[indexPath.row].configure(item: item)
            return item
        case ItemType.footer:
            guard let footer: ItemPresenter = self.sectionsPresenters[indexPath.section].footer else { break }
            let item: UICollectionReusableView = collectionView.item(for: indexPath, type: type, id: footer.id)
            self.sectionsPresenters[indexPath.section].footer?.configure(item: item)
            return item
        }
        
        return UICollectionReusableView()
    }
}

