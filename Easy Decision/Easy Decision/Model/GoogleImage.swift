//
//  GoogleImage.swift
//  Easy Decision
//
//  Created by Danny Navarro on 4/4/18.
//

import Foundation

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
        guard let json_items = json["items"] as? [String:Any],
            let jContextLink = json_items["contextLink"] as? String,
            let jHeight = json["height"] as? Int,
            let jWidth = json["width"] as? Int,
            let jByteSize = json["byteSize"] as? Int,
            let jThumbnailLink = json["thumbnailLink"] as? String,
            let jThumbnailHeight = json["thumbnailHeight"] as? Int,
            let jThumbnailWidth = json["thumbnailWidth"] as? Int
            else
        {
            return nil
        }
        
        self.contextLink = jContextLink
        self.height = jHeight
        self.width = jWidth
        self.byteSize = jByteSize
        self.thumbnailLink = jThumbnailLink
        self.thumbnailHeight = jThumbnailHeight
        self.thumbnailWidth = jThumbnailWidth
    }
}

extension GoogleImage {
    
    static func search(with decision_url:URL, completion:@escaping (GoogleImage?)->Void){
        
        let urlReq = URLRequest(url: decision_url)
        let config = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: config)
        
        
        urlSession.dataTask(with: urlReq) { (data, response, error) in
            defer {
                print("")
            }
            
            //Check for errors
            guard error == nil else {
                print("Error in URL Request for \(decision_url.absoluteURL)")
                print(error!)
                return
            }
            //Get the data
            do {
            if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any],
                let googleImage = GoogleImage(json: json){
                completion(googleImage)
            } else {
                print("Error: data not received")
                return
            }
            } catch {
                print("Error:parsing data into JSON failed")
            }
            
        }.resume()
    }
}
