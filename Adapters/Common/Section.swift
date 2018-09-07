//
//  Section.swift
//  Adapters
//
//  Created by Konrad on 07/09/2018.
//  Copyright © 2018 Konrad. All rights reserved.
//

import Foundation

struct Section: SectionPresenter { 
    var header: ItemPresenter?
    var subitems: [ItemPresenter]
    var footer: ItemPresenter?
}
