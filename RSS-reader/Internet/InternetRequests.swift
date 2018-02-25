//
//  InternetRequests.swift
//  RSS-reader
//
//  Created by Sergey on 22.02.2018.
//  Copyright © 2018 Sergey Kochetov. All rights reserved.
//

import Alamofire

class InternetRequests {
    
    class func getNewsFromURL(url: String, successBlok: @escaping (Data)->(), failureBlock: @escaping (Int)->()) {
        request(url).responseData { (response) in
            if response.error != nil {
                failureBlock(-999)
            } else {
                successBlok(response.data!)
            }
        }
    }
    
}
