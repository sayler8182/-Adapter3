//
//  DashboardViewController.swift
//  Adapters
//
//  Created by Konrad on 25/08/2018.
//  Copyright © 2018 Konrad. All rights reserved.
//

import UIKit

protocol DashboardViewProtocol: class {
    var presenter: DashboardPresenterProtocol! { get set }
}

class DashboardViewController: UIViewController, DashboardViewProtocol {
    lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: self.view.bounds)
        tableView.register(type: HeaderView.self, itemType: ItemType.header)
        tableView.register(type: StringTableViewCell.self)
        tableView.register(type: IntTableViewCell.self)
        tableView.register(type: ModelTableViewCell.self)
        tableView.backgroundColor = UIColor.lightGray
        tableView.set(adapter: self.presenter.adapter)
        return tableView
    }()
    
    var presenter: DashboardPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
    }
}

