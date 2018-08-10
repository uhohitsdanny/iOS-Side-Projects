//
//  DecisionPackage.swift
//  Easy Decision
//
//  Created by Danny Navarro on 3/16/18.
//

import Foundation

class DecisionPackage {
    private var decision_list: [Decision]
    var googleImages:[GoogleImage] = []

    init(dlist:[Decision]) {
        self.decision_list = dlist
    }
}
//
//Google Image Query
//
extension DecisionPackage {
    func queryGoogleImages() {
        let api_key:String = "AIzaSyApuuAKuPkDwCD-BmOUbehJBRactgLMAro"
        let se_key:String = "003175788915269873568:bexhnpdk94a"
        var query:String = ""
        
        for input in stride(from: 0, to: self.decision_list.count, by: 1) {
            let group = DispatchGroup()
            group.enter()
            
            query = self.decision_list[input].str
            let url = "https://www.googleapis.com/customsearch/v1?key=\(api_key)&cx=\(se_key)&q=\(query)&searchType=image&imgSize=huge&num=10"
            guard let url_request = URL(string: url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!) else {
                log("Error: URL cannot be created")
                return
            }

            GoogleImage.search(with: url_request, completion: { (googleImage) in
                self.googleImages.append(googleImage)
                log("===================== SUCCESS =====================")
                group.leave()
            })
            group.wait()
        }
        log("===================== DONE =====================")
        print(self.googleImages)
    }
}
