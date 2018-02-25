//
//  DataSource.swift
//  RSS-reader
//
//  Created by Sergey on 22.02.2018.
//  Copyright © 2018 Sergey Kochetov. All rights reserved.
//

import Foundation
import SWXMLHash

class DataSource {
    
    private static var arrOfNews = [News]()
    
    class func getNews( url : String, successBlock: @escaping  ()-> Void, failureBlock: @escaping  (Int) -> Void) {
        InternetRequests.getNewsFromURL(url: url, successBlok: { (data) in
            let xml = SWXMLHash.config({ (config) in
                config.shouldProcessLazily = false
            }).parse(data)
            
            let items = xml["rss"]["channel"]["item"].all
            let source = xml["rss"]["channel"]["title"].element?.text
            for each in items {
                let newsTitle       = each["title"].element?.text
                let newsDescription = each["description"].element?.text
                let strDate         = each["pubDate"].element?.text
                let urlStr          = each["enclosure"].element?.attribute(by: "url")?.text
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
                dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone!
                let date = dateFormatter.date(from: strDate ?? "")
                
                guard let source = source
                    , let title = newsTitle
                    , let descr = newsDescription
                    , let d = date else { continue }
                
                let news = News(source: source, title: title, imageURL: URL(string: urlStr ?? ""), description: descr, date: d)
                
                arrOfNews.append(news)
            }
            self.arrOfNews.sort(by: { ($0.date > $1.date) })
            successBlock()
        }, failureBlock: failureBlock)
    }
    
    
    class func numberOfRowsInSection() -> Int {
        return arrOfNews.count
    }
    
    class func model(atIndexPath indexPath: IndexPath) -> AnyObject {
        return arrOfNews[indexPath.row]
    }
    
}
