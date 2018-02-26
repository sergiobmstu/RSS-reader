//
//  DependencyInjector.swift
//  RSS-reader
//
//  Created by Sergey on 23.02.2018.
//  Copyright © 2018 Sergey Kochetov. All rights reserved.
//

import Foundation

class DependencyInjector {
    
    class func assignPresenter(view: ViewProtocol) {
        var presenter: Presenter?
        
        if view is NewsVC {
            presenter = NewsPresenter()
        }
        
        if let presenter = presenter {
            view.assignPresenter(presenter: presenter)
        }
    }
}
