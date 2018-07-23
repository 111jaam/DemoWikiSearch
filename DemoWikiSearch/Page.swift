//
//  Page.swift
//  DemoWikiSearch
//
//  Created by Bharat Byan on 23/07/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//

import Foundation
import SwiftyJSON

class Page {
    var pageid : NSNumber?
    var title : String?
    var thumbnail : URL?
    var description : String?
    init(obj:JSON?) {
        self.pageid = obj!["pageid"].number
        self.title = obj!["title"].string
        self.description = obj!["terms"]["description"][0].string
        self.thumbnail = obj!["thumbnail"]["source"].url
    }
}
