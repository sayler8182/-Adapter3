//
//  DashboardPresenter.swift
//  Adapters
//
//  Created by Konrad on 25/08/2018.
//  Copyright © 2018 Konrad. All rights reserved.
//

import Foundation

protocol DashboardPresenterProtocol: class {
    var view: DashboardViewProtocol { get }
    var adapter: AdapterProtocol    { get }
}

class DashboardPresenter: DashboardPresenterProtocol {
    let view: DashboardViewProtocol
    let adapter: AdapterProtocol
    
    init(view: DashboardViewProtocol,
         adapter: AdapterProtocol) {
        self.view = view
        self.adapter = adapter
        
        // data source
        let presenters1: [ItemPresenter] = [
            StringCellPresenter(model: "One"),
            StringCellPresenter(model: "Two"),
            StringCellPresenter(model: "Three"),
        ]
        let presenters2: [ItemPresenter] = [
            IntCellPresenter(model: 4),
            IntCellPresenter(model: 5),
            IntCellPresenter(model: 6)
        ]
        let presenters3: [ItemPresenter] = [
            ModelCellPresenter(model: Model(x: 7, y: 8)),
        ]
        
        // sections
        let section1: SectionPresenter = Section(
            header: HeaderViewPresenter(model: "Header 1"),
            subitems: presenters1,
            footer: nil)
        let section2: SectionPresenter = Section(
            header: HeaderViewPresenter(model: "Header 2"),
            subitems: presenters2,
            footer: nil)
        let section3: SectionPresenter = Section(
            header: HeaderViewPresenter(model: "Header 3"),
            subitems: presenters3,
            footer: nil)
        
        self.adapter.set(presenters: [section1, section2, section3])
    }
}
