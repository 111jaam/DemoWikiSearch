//
//  APIManager.swift
//  DemoWikiSearch
//
//  Created by Bharat Byan on 23/07/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class APIManager: NSObject {
    
    let baseURL = "https://en.wikipedia.org//w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpssearch="
    static let sharedInstance = APIManager()
    static let endpoint = "&gpslimit=10"
    
    func callWikiAPI(searchText: String, onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void) {
        
        let searchText: String = (searchText.replacingOccurrences(of: " ", with: "+"))
        let url: String = baseURL + searchText + APIManager.endpoint
                
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if(error != nil){
                onFailure(error!)
            } else{
                do {
                    let json = try JSON(data: data!)
                    onSuccess(json)
                } catch {
                    print(error)
                    // or display a dialog
                }
            }
        })
        task.resume()
    }
}
