//
//  NetworkModel.swift
//  Easy Decision
//
//  Created by Danny Navarro on 4/2/18.
//

import Foundation

//JSON REST API
//"image": {
//"contextLink": string,
//"height": integer,
//"width": integer,
//"byteSize": integer,
//"thumbnailLink": string,
//"thumbnailHeight": integer,
//"thumbnailWidth": integer
struct GoogleImage {
    let contextLink:String?
    let height:Int?
    let width:Int?
    let byteSize:Int?
    let thumbnailLink:String?
    let thumbnailHeight:Int?
    let thumbnailWidth:Int?
}

extension GoogleImage {
    init?(json:[String:Any]) {
            guard let jContextLink = json["contextLink"] as? String,
                let jHeight = json["height"] as? Int,
                let jWidth = json["width"] as? Int,
                let jByteSize = json["byteSize"] as? Int,
                let jThumbnailLink = json["thumbnailLink"] as? String,
                let jThumbnailHeight = json["thumbnailHeight"] as? Int,
                let jThumbnailWidth = json["thumbnailWidth"] as? Int
            else {
                return nil
            }
        }
    }
}
