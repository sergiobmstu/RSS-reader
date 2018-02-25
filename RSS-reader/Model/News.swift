//
//  News.swift
//  RSS-reader
//
//  Created by Sergey on 20.02.2018.
//  Copyright © 2018 Sergey Kochetov. All rights reserved.
//

import Foundation

class News {
    let source: String
    let title: String
    var imageURL: URL?
    let description: String
    let date: Date
    var isOpen = false
   
    init(source : String, title: String, imageURL: URL?, description: String, date: Date) {
        self.source = source
        self.title = title
        self.imageURL = imageURL
        self.description = description
        self.date = date
    }
    
}
