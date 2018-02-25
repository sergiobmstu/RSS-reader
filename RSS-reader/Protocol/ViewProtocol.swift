//
//  View.swift
//  RSS-reader
//
//  Created by Sergey on 23.02.2018.
//  Copyright © 2018 Sergey Kochetov. All rights reserved.
//

import Foundation

protocol ViewProtocol: class {
    func assignPresenter(presenter: Presenter)
    func reloadData()
    func handleErrorCode(_ code: Int)
}
