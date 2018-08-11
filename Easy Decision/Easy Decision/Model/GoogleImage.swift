//
//  GoogleImage.swift
//  Easy Decision
//
//  Created by Danny Navarro on 4/4/18.
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



struct GoogleImage: Decodable{
    let items: [Items]?
}

struct Items: Decodable {
    let title: String?
    let link: String?
    let image: Image?
}

struct Image: Decodable {
    let contextLink:String?
    let height:Int?
    let width:Int?
    let byteSize:Int?
    let thumbnailLink:String?
    let thumbnailHeight:Int?
    let thumbnailWidth:Int?
}

extension GoogleImage {
    
    static func search(with decision_url:URL, completion:@escaping (GoogleImage)->Void){
        
        print("URL IS \(decision_url.description)")
        let urlSession = URLSession(configuration: .default)
        
        
        urlSession.dataTask(with: decision_url) { (data, response, error) in
            defer {
                print("")
            }
            //Check for errors
            guard error == nil else {
                log("\(error!)")
                return
            }
            //Check data
            guard let validData = data else {
                log("Error: could not retrieve data")
                return
            }
            //Get the data
            let json_decoder = JSONDecoder()
            do {
                let googleImages = try json_decoder.decode(GoogleImage.self, from: validData)
                
                completion(googleImages)
            } catch {
                log("Error:parsing data into JSON failed")
            }
            
        }.resume()
    }
    
    //Perform data task url session again, but this time with the link
    //that was received from the google search
    static func retrieveImage(with img_url:URL, completion:@escaping (Data) -> Void){
        
        log("Retrieving image from \(img_url.absoluteURL)")
        let urlSession = URLSession(configuration: .default)
        
        urlSession.dataTask(with: img_url) { (data, response, error) in
            guard error == nil else {
                log("\(error!)")
                return
            }
            
            guard let validData = data else {
                log("Error: could not retrieve image data")
                return
            }
            
            completion(validData)
        }.resume()
    }
}
