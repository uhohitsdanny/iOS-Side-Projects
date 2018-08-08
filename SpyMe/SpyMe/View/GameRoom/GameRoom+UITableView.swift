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
        return (self.gameroom_VM?.locs.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as! LocationCell
        
        cell.locationLabel.text = self.gameroom_VM?.locs[indexPath.row]
        
        return cell
    }
}
