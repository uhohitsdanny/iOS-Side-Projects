//
//  GameRoom+UITableView.swift
//  SpyMe
//
//  Created by Danny Navarro on 8/7/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import Foundation

extension GameRoom_VC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as! LocationCell
        
        return cell
    }
}
