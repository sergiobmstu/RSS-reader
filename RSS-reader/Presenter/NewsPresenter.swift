//
//  NewsPresenter.swift
//  RSS-reader
//
//  Created by Sergey on 23.02.2018.
//  Copyright © 2018 Sergey Kochetov. All rights reserved.
//

import Foundation

class NewsPresenter: Presenter {
    
    weak var view: ViewProtocol?
    
    func viewLoaded(view: ViewProtocol) {
        self.view = view
    }
    
    func provideDate() {
        getDate()
    }
    
    func numberOfModel(inSection : Int) -> Int {
        return DataSource.numberOfRowsInSection()
    }
    
    func getModel(atIndexPath : IndexPath) -> AnyObject {
        return DataSource.model(atIndexPath: atIndexPath)
    }
    
    private func getDate() {
        DataSource.getNews(url: Constants.AppConsts.kGazetaRuUrl, successBlock: {
            DataSource.getNews(url: Constants.AppConsts.kLentaRuUrl, successBlock: {
                self.view?.reloadData()
            }, failureBlock: { (errorCode) in
                 self.view?.handleErrorCode(errorCode)
            })
        }) { (errorCode) in
            self.view?.handleErrorCode(errorCode)
        }
    
    }
    
    
    
}
