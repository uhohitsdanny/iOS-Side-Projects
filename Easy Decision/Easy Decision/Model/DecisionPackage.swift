//
//  DecisionPackage.swift
//  Easy Decision
//
//  Created by Danny Navarro on 3/16/18.
//

import Foundation

class DecisionPackage {
    private var decision_list: [Decision]
    
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
            query = self.decision_list[input].str
            let request_url = "https://www.googleapis.com/customsearch/v1?key=\(api_key)&cx=\(se_key)&q=\(query)&searchType=image"
        }
        
        
    }
}

//
// Getter Functions
//
extension DecisionPackage {
    
//    func getId() -> Int {
//        return self.dId!
//    }
//
//    func getImg() -> String {
//        return self.img!
//    }
//
//    func getDecision() -> String {
//        return self.str
//    }
//
//    func getSts() -> NSNumber {
//        return self.sts!
//    }
}

//
// Setter Functions
//
extension DecisionPackage {
    
//    mutating func setDecision(decision: String) -> Void {
//        self.str = decision
//    }
//
//    mutating func setDecisionID(id: Int) -> Void {
//        self.dId = id + 1
//    }
//
//    mutating func setDecisionImg(decision: Decision) {
//
//    }
}
