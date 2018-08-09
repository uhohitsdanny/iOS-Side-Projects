//
//  VotingPopup+UITableView.swift
//  SpyMe
//
//  Created by Danny Navarro on 8/9/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import Foundation

extension VotingPopup_VC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerCell
        cell.selectionStyle = .none
        
        cell.point1.isHidden = false
        cell.point2.isHidden = false
        
        cell.nameLabel.text = self.players[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PlayerCell
        cell.point1.isHidden = false
        cell.point2.isHidden = false
        
        log("Voted for \(self.players[indexPath.row])")
        self.votedplayer = self.players[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PlayerCell
        cell.point1.isHidden = true
        cell.point2.isHidden = true
    }
}
