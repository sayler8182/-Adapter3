//
//  AdapterProtocol.swift
//  Adapters
//
//  Created by Konrad on 25/08/2018.
//  Copyright © 2018 Konrad. All rights reserved.
//

import Foundation
import UIKit
 
protocol AdapterProtocol: UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var list: UIList?                           { get }
    var presenters: [ItemPresenter]             { get }
    var sectionsPresenters: [SectionPresenter]  { get }
    var sectionsCount: Int                      { get }
    
    func reload(presenters: [ItemPresenter?])
    func reload(indexPathes: [IndexPath?])
    func insert(indexPathes: [IndexPath?])
    func insert(presenters: [ItemPresenter])
    func insert(presenters: [SectionPresenter])
    func reload()
    
    func set(list: UIList?)
    func set(presenters: [ItemPresenter])
    func set(presenters: [SectionPresenter])
    
    func indexPathes(presenters: [ItemPresenter?]) -> [IndexPath]
    func indexPath(presenter: ItemPresenter?) -> IndexPath?
    func rowsCount(for section: Int) -> Int
    func size(for path: IndexPath) -> CGSize
    func selected(at path: IndexPath)
    func configure(cell: UIView, at path: IndexPath)
    func item<T: UIView>(for path: IndexPath, with list: UIList, with type: ItemType) -> T
    
    // tableView
    func numberOfSections(in tableView: UITableView) -> Int
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    
    // collectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
}
