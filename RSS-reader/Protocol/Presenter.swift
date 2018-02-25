//
//  Presenter.swift
//  RSS-reader
//
//  Created by Sergey on 23.02.2018.
//  Copyright © 2018 Sergey Kochetov. All rights reserved.
//

import Foundation

protocol Presenter: class {
    func viewLoaded(view: ViewProtocol)
    func provideDate()
    func numberOfModel(inSection: Int) -> Int
    func getModel(atIndexPath: IndexPath) -> AnyObject
}
